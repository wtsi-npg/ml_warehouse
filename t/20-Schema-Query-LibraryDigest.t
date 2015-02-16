use strict;
use warnings;
use Test::More tests => 29;
use Test::Exception;
use Test::Warn;
use YAML qw/ LoadFile /;
use DateTime;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest');

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

my $schema;
lives_ok { 
  $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:');
  $schema->deploy();
  _load_fixtures($schema, 't/data/fixtures');
} 'created in-memory test database';

my $products = $schema->resultset('IseqProductMetric');
my $flowcells = $schema->resultset('IseqFlowcell');

my $ldclass = 'WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest';

{
  throws_ok { $ldclass->new() } 
    qr/Attribute \(iseq_product_metrics\) is required/, 
    'iseq_product_metrics attribute should be defined';

  throws_ok { $ldclass->new(iseq_product_metrics => [4,5]) }
    qr/Attribute \(iseq_product_metrics\) does not pass the type constraint/, 
    'iseq_product_metrics attribute should be DBIx::Class::ResultSet object';

  throws_ok { $ldclass->new(iseq_product_metrics => $flowcells) }
    qr/Got WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell, expected result set for IseqProductMetric/, 
    'iseq_product_metrics attribute should represent iseq_product_metrics metrics';

  throws_ok {$ldclass->new(
        iseq_product_metrics => $products,
        group_by => 'study',
  ) } qr/Cannot group by study, known aggregation leveles: library, sample/,
  'error for invalid group_by value';

  throws_ok {$ldclass->new(
        iseq_product_metrics => $products,
        filter => 'library',
  ) } qr/Cannot filter by library, known filteres: extrelease, mqc/,
  'error for invalid filter value';
}

{
  my $d;
  lives_ok { $d = $ldclass->new(iseq_product_metrics => $products) } 'digest object created';
  isa_ok ($d, $ldclass);
  
  is ($d->group_by, 'library', 'default grouping is by library');
  ok (!$d->filter, 'filter is not set by default');
  ok (!$d->accept_undefined, 'undefined filter values are not included by default');
  ok (!$d->include_control, 'control samples are not included by default');
  ok (!$d->include_rad, 'r&d samples are not included by default');
  ok (!$d->completed_after, 'completed after date is not set by default');
  ok (!@{$d->completed_within}, 'completed_within array is empty by default');
  ok (!$d->earliest_run_status, 'earliest_run_status is not set by default');
  throws_ok {$d->id_run} qr/Should have earliest run status/,
    'error creating list of runs when earliest_run_status is not defined';
  ok (!@{$d->_valid_run_statuses},
  'valid run statuses are not computed if earliest_run_status is not defined');
  ok (!$d->_time_interval_query, 'time query is undefined');
  lives_ok { $d->create } 'can create digest with all options set to defaults';

  throws_ok {$ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status => 'some status',
             )->create()
  } qr/Time limits should be defined/,
  'error when time limits are not defined';

  throws_ok {$ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'some status',
        completed_after      => DateTime->now()
             )->create()
  } qr/Invalid run status: 'some status'/,
  'error when earliest_run_status is an invalid status';
}

{
  my $d = $ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'qc review pending',
        completed_after      => DateTime->now()
                       );
  is(join(q[:], sort @{$d->_valid_run_statuses()}),
    'archival in progress:archival pending:qc complete:qc in progress:qc review pending:run archived',
    'set of run statuses to consider');

  $d = $ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'qc complete',
        completed_after      => DateTime->now()
                       );
  is(join(q[:], sort @{$d->_valid_run_statuses()}), 'qc complete',
    'set of run statuses to consider');
  ok(!@{$d->id_run()}, 'no new runs');
  my $h;
  warning_like { $h = $d->create() } qr/Digest is empty/, 'warning about an empty digest';
  is( scalar keys %{$h}, 0, 'digest is empty');
}

1;