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

my $RUN_TABLE_NAME = q[PacBioRun];

my $schema;
lives_ok {
  $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') ;
  $schema->deploy() ;
  _load_fixtures($schema, 't/data/fixtures');
} 'created in-memory test database';


subtest 'test_get_tags' => sub {
  plan tests => 4;

  my $rs1 = $schema->resultset($RUN_TABLE_NAME)->search
    ({pac_bio_run_name => 'TRACTION-RUN-157', well_label => 'A1'});
  my $row1 = $rs1->next;
  is(WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric->get_tags($row1), 'ACACTAGATCGCGTGTT,CTATACGTATATCTATT',
    'Correct tag list for product with two tag sequences');

  my $rs2 = $schema->resultset($RUN_TABLE_NAME)->search
    ({ pac_bio_run_name => '80685', well_label => 'D1'});
  my $row2 = $rs2->next;
  is(WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric->get_tags($row2), 'CGCATGACACGTGTGTT',
    'Correct tag list for product with one tag sequence');

  my $rs3 = $schema->resultset($RUN_TABLE_NAME)->search
    ({ pac_bio_run_name => 'TRACTION-RUN-157', well_label => 'D1'});
  my $row3 = $rs3->next;
  is(WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric->get_tags($row3), '',
    'Empty tag list for product with zero tag sequences');

  throws_ok(sub { WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric->get_tags; }, qr/A defined row argument is required*/,
    'Fails due to lack of $row argument');

};

1;
