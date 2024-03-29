use strict;
use warnings;
use Test::More tests => 10;
use Test::Exception;
use File::Temp qw(tempdir);
use File::Spec::Functions;

use_ok('WTSI::DNAP::Warehouse::Schema');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
isa_ok ($schema, 'WTSI::DNAP::Warehouse::Schema');
lives_ok { $schema->deploy() } 'schema deployed';

{
  my $rl_rs = $schema->resultset('IseqRunLaneMetric');
  my $p_rs  = $schema->resultset('IseqProductMetric');
  for ((1 ... 8)) {
    my $h = {id_run => 4, position => $_};
    my %rlrow = %{$h};
    $rlrow{cycles} = 37;
    $rl_rs->create(\%rlrow);
    if ($_ < 5) {
      $h->{id_iseq_product} = 'digest' . $_;
      $p_rs->create($h);
    } 
  }
  is ($rl_rs->search({id_run => 4})->count(), 8,
    '8 lanes for run 4 created in run-lane table - test prereq.');
  is ($p_rs->search({id_run => 4})->count(), 4,
    '4 lanes for run 4 created in product table - test prereq.');

  is ($rl_rs->search({'me.id_run' => 4},  {join => 'iseq_product_metrics',},)->count(), 8,
    'left join is performed from run lane to product by default');
  is ($rl_rs->search({'me.id_run' => 4},  {join => 'iseq_product_metrics_inner',},)->count(), 4,
    'inner join from run lane to product via custom relationship');
  is ($p_rs->search({'me.id_run' => 4},  {join => 'iseq_run_lane_metric',},)->count(), 4,
    'inner join is performed from product to run lane by default');

  SKIP: {
    my $outer_join_supported = 0;
    my $sqlite_version = q[];

    eval {
      my $db = DBI->connect("dbi:SQLite:dbname=dummy", "", "");
      $sqlite_version = $db->{sqlite_version};
      my ($major, $minor, $patch) = split /./, $sqlite_version;
      if ($major && int($major) == 3 && $minor && int($minor) >= 39) {
        $outer_join_supported = 1;
      }
    };

    skip "A version of SQLite supporting outer joins is not present: $sqlite_version", 1,
        if !$outer_join_supported;

    is($p_rs->search({ 'iseq_run_lane_metric_right.id_run' => 4 }, { join => 'iseq_run_lane_metric_right', },)->count(), 8,
        'right join is performed from product to run lane via custom relationship');
  };
}

1;
