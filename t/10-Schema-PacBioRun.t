use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;
use YAML qw/ LoadFile /;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Result::PacBioRun');

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

my $RUN_TABLE_NAME = q[PacBioRun];

my $schema;
lives_ok {
  $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') ;
  $schema->deploy() ;
  _load_fixtures($schema, 't/data/fixtures');
} 'created in-memory test database';


subtest 'test_get_tags' => sub {
  plan tests => 3;

  my $rs1 = $schema->resultset($RUN_TABLE_NAME)->search
    ({pac_bio_run_name => 'TRACTION-RUN-157', well_label => 'A1'});
  my $row1 = $rs1->next;
  is(join(q[,], @{$row1->get_tags}), 'ACACTAGATCGCGTGTT,CTATACGTATATCTATT',
    'Correct tag list for product with two tag sequences');

  my $rs2 = $schema->resultset($RUN_TABLE_NAME)->search
    ({ pac_bio_run_name => '80685', well_label => 'D1'});
  my $row2 = $rs2->next;
  is(join(q[,], @{$row2->get_tags}), 'CGCATGACACGTGTGTT',
    'Correct tag list for product with one tag sequence');

  my $rs3 = $schema->resultset($RUN_TABLE_NAME)->search
    ({ pac_bio_run_name => 'TRACTION-RUN-157', well_label => 'D1'});
  my $row3 = $rs3->next;
  is(join(q[,], @{$row3->get_tags}), '',
    'Empty tag list for product with zero tag sequences');

};

1;
