use strict;
use warnings;
use Test::More tests => 49;
use Test::Exception;
use Test::Warn;
use YAML qw/ LoadFile /;
use DateTime;
use DateTime::Duration;
use DateTime::Format::SQLite;

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
  ) } qr/Cannot group by study, known aggregation levels: library, sample/,
  'error for invalid group_by value';

  throws_ok {$ldclass->new(
        iseq_product_metrics => $products,
        filter => 'library',
  ) } qr/Cannot filter by library, known filters: extrelease, mqc/,
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
  my $results;
  lives_ok { $results = $d->create } 'can create digest with all options set to defaults';


  ok (scalar keys %$results == 14, '14 library ids in digest');

  my $d1;
  lives_ok { $d1 = $ldclass->new(
            iseq_product_metrics => $products,
            library_id => [12789790],
            )->create()
           } 'digest object restricted to 1 library id created';
             
  ok (scalar keys %$d1 == 1, 'Only 1 library id in digest'); 

  my $d2;
  lives_ok { $d2 = $ldclass->new(
            iseq_product_metrics => $products,
            id_run => [15534,15454],
            library_id => [12789790],
            )->create()
     } 'Both id_run and library_id can be specified together';

   ok (scalar keys %$d2 ==  0, 'No results if supplied library_id is not in supplied id_run list');

##TODO Need a library id over multiple runs
   my $d3;
  lives_ok { $d3 = $ldclass->new(
            iseq_product_metrics => $products,
            id_run => [15440],
            library_id => [12789790],
            )->create()
     } '1 id_run and 1 library_id';

is( join(q[:], map { $_->{rpt_key} } @{$d3->{12789790}{HiSeq}{paired}{entities}} ), '15440:1:81:15440:2:81',
    'rpts 15440:1:81:15440:2:81 returned when id_run 15440 library_id 12789790 are specified' );


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


  my $study_mqc;   #qc is in table iseq_product_metrics
  lives_ok { $study_mqc = $ldclass->new(
            iseq_product_metrics => $products,
            earliest_run_status => 'qc complete',
            filter              => 'mqc', 
            id_study_lims       => '2967',
       )->create()
     } 'id_study_lims and filter mqc';

  is (scalar(keys %$study_mqc),'1', '1 library returned');
  is (scalar(@{$study_mqc->{12789790}{HiSeq}{paired}{entities}}),'1', '1 entity returned for library 12789790');
  is ($study_mqc->{12789790}{HiSeq}{paired}{entities}[0]->{'rpt_key'},'15440:1:81',
    'rpt_key 15440:1:81 returned when querying by earliest_run_status qc complete, filter mqc and id_study_lims 2967');


  my $extr;
  lives_ok { $extr = $ldclass->new(
            iseq_product_metrics => $products,
            earliest_run_status => 'qc complete',
            filter              => 'extrelease', #external_release is in table iseq_flowcell
            id_study_lims       => '2967',
       )->create()
     } 'filter on external_release';


   is (scalar(keys %$extr),'3', '3 libraries returned');
   is (scalar(@{$extr->{12789814}{HiSeq}{paired}{entities}}),'2', '2 entities returned for library 12789814');
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

my $date = DateTime->now();

my $rs = $schema->resultset('IseqRunStatus')->search(
  {iscurrent => 1}, {'order_by' => 'id_run'});
while (my $row = $rs->next) {
  if ($row->id_run == 15440) {
    $date->subtract_duration(DateTime::Duration->new(days => 2));
    $row->update({'date' => $date});
  } elsif ($row->id_run == 15454) {
    $date->subtract_duration(DateTime::Duration->new(days => 3));
    $row->update({'date' => $date});
  }
}

{
  my $adate = DateTime->now();
  $adate->subtract_duration(DateTime::Duration->new(days => 3));

  my $d = $ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'qc complete',
        completed_after      => $adate,
                       );
  is( join(q[:], @{$d->id_run}), 15440, 'runs completed within three days' );

  $adate->subtract_duration(DateTime::Duration->new(days => 3));
  $d = $ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'qc complete',
        completed_after      => $adate,
                     );
  is( join(q[:], @{$d->id_run}), 15440, 'runs completed within six days' );
  $d = $ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'qc review pending',
        completed_after      => $adate,
                     );
  is( join(q[:], sort {$a <=> $b} @{$d->id_run}), '15440:15454',
    'runs reached at least qc review within six days' );
  my $results = $d->create();
  is (join(q[:], sort {$a <=> $b} keys %{$results}),
  '12789790:12789802:12789814:12789826:12977046:12977047:12977048:12977049:12977050:12977051:12977052:12977053:12977054:12977055',
  'library keys');

  $d = $ldclass->new(
        iseq_product_metrics => $products,
        earliest_run_status  => 'qc review pending',
        completed_after      => $adate,
        group_by             => 'sample'
                    );
  $results = $d->create();
  is (join(q[:], sort {$a <=> $b} keys %{$results}),
  '1877285:1877289:1877292:1877306:2227349:2227350:2227351:2227352:2227353:2227354:2227355:2227356:2227357:2227358',
  'sample keys');

  my $e1 = {
    'flowcell_barcode' => 'HBF2DADXX',
    'status'           => 'qc complete',
    'library'          => 12789826,
    'id_lims'          => 'SQSCP',
    'new_library_id'   => 'DN384378S:D11',
    'library_type'     => 'Standard',
    'rpt_key'          => '15440:1:84',
    'sample_name'      => undef,
    'sample_accession_number' => 'ERS429041',
    'sample_common_name' => 'Homo Sapien',
    'sample'           => '1877306',
    'study'            => '2967',
    'study_title'      => 'Lebanon_LowCov-seq',
    'study_name'       => 'SEQCAP_Lebanon_LowCov-seq',
    'study_accession_number' => 'ERP005180',
    'reference_genome' => 'Homo_sapiens (1000Genomes_hs37d5)',
    'aligned'          => '1',
    'cycles'           => '208',
    'expected_cycles'  => '208',
  };

  my %e2 = %{$e1};
  $e2{'rpt_key'} = '15440:2:84';
  my $expected = {};
  $expected->{'HiSeq'}->{'paired'}->{'entities'} = [$e1, \%e2];

  is_deeply( $results->{'1877306'}, $expected, 'set of results for one of the samples');
}

1;
