use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;
use YAML qw/ LoadFile /;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric');

sub _load_fixtures {
    my ($schema, $path) = @_;

    opendir my $dh, $path or die "Could not open $path";
    my @fixtures = sort grep { /[.]yml$/smix } readdir $dh;
    closedir $dh;
    if (scalar @fixtures == 0) { die qq[no fixtures found at $path]; }

    for my $fx (@fixtures) {
        my $yml  = LoadFile("$path/$fx");
        my @temp = split m/[._]/sxm, $fx;
        pop @temp;
        my $table = join q[.], @temp;
        $table =~ s/^(\d)+-//smx;
        warn "+- Loading $fx into $table\n";
        my $rs = $schema->resultset($table);
        foreach my $row (@{$yml}) {
           $rs->create($row);
        }
    }
    return;
}

my $RUN_TABLE_NAME = q[PacBioProductMetric];

my $schema;
lives_ok {
  $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') ;
  $schema->deploy() ;
  _load_fixtures($schema, 't/data/fixtures');
} 'created in-memory test database';


subtest 'test_get_tags' => sub {
  plan tests => 2;

  my $rs1 = $schema->resultset($RUN_TABLE_NAME)->search
    ({id_pac_bio_pr_metrics_tmp => '7879'});
  my $row1 = $rs1->next;
  is(join(q[,], @{$row1->get_tags}), 'ACACTAGATCGCGTGTT,CTATACGTATATCTATT',
    'Correct tag list for linked product');

  my $rs2 = $schema->resultset($RUN_TABLE_NAME)->search
    ({ id_pac_bio_pr_metrics_tmp => '7931'});
  my $row2 = $rs2->next;
  dies_ok{ $row2->get_tags} ,
    'Error when no pac_bio_run row is linked';

};

1;
