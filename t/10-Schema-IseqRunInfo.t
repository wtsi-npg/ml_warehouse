use strict;
use warnings;
use Test::More tests => 7;
use Test::Exception;
use Test::Warn;
use Perl6::Slurp;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema
                     ->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
lives_ok { $schema->deploy() } 'schema deployed';

my $rs_run_info = $schema->resultset('IseqRunInfo');

subtest 'create a row' => sub {
  plan tests => 7;

  my $simple1 = <<'SIMPLE1'
<?xml version="1.0"?>
<RunParameters>
</RunParameters>
SIMPLE1
;

  my $simple2 = <<'SIMPLE2'
<?xml version="1.0"?>
<RunParameters>some</RunParameters>
SIMPLE2
;

  my $data = {id_run => 45678};
  lives_ok { $rs_run_info->create($data) } 
    'create a row with run params data undefined';
  my $row = $rs_run_info->find($data->{id_run});
  is ($row->run_parameters_xml, undef, 'run params data is undefined');
  warning_is { $row->update({run_parameters_xml => $simple1}) }
    'iseq_run table: no data for run 45678',
    'warning - no data in the parent table';
  is ($row->run_parameters_xml, $simple1, 'run params. is correctly updated');
  
  $data->{run_parameters_xml} = 'tyuuuuuu';
  throws_ok { $rs_run_info->create($data) }
    qr/UNIQUE constraint failed/,
    'Cannot create a row with the run id of the existing row';

  $data = {id_run => 45679, run_parameters_xml => $simple2};
  warning_is { $rs_run_info->create($data) }
    'iseq_run table: no data for run 45679',
    'create a row with run params data defined';
  $row = $rs_run_info->find($data->{id_run});
  is ($row->run_parameters_xml, $simple2, 'run params data'); 
};

subtest 'test relation to iseq_run' => sub {
  plan tests => 4;

  my $row = $rs_run_info->find(45678);
  is ($row->iseq_run(), undef, 'no related row');

  $schema->resultset('IseqRun')->create(
    {id_run => 45678, id_flowcell_lims => 3567});
  my $related = $row->iseq_run();
  is (ref $related, 'WTSI::DNAP::Warehouse::Schema::Result::IseqRun',
   'relation returns a row');
  is ($related->id_run, 45678, 'correct run id');
  is ($related->id_flowcell_lims, 3567, 'correct batch id');
};

subtest 'test updating run params columns' => sub {
  plan tests => 21;

  my $name = 'RunParameters_NovaSeq.xml';
  my $contents = slurp "t/data/run_params/$name";

  my $row = $rs_run_info->find(45678);
  ok ($row->run_parameters_xml ne $contents,
    'current data is different from the content of ' . $name);
  my $run_row = $row->iseq_run();
  is ($run_row->rp__read1_number_of_cycles, undef,
    'read1_number_of_cycles - undefined');
  is ($run_row->rp__read2_number_of_cycles, undef,
    'read2_number_of_cycles - undefined');
  is ($run_row->rp__flow_cell_mode, undef,
    'flow_cell_mode - undefined');
  is ($run_row->rp__workflow_type, undef,
    'workflow_type - undefined');
  is ($run_row->rp__flow_cell_consumable_version, undef,
    'flow_cell_consumable_version - undefined');
  is ($run_row->rp__sbs_consumable_version, undef,
    'sbs_consumable_version - undefined');
  
  # update existing row
  $row = $rs_run_info->update_or_create(
    {id_run => 45678, run_parameters_xml => $contents});
  is ($row->run_parameters_xml, $contents, 'contents is updated');
  $run_row = $row->iseq_run();
  is ($run_row->rp__read1_number_of_cycles, 221, 'read1_number_of_cycles');
  is ($run_row->rp__read2_number_of_cycles, 201, 'read2_number_of_cycles');
  is ($run_row->rp__flow_cell_mode, 'SP', 'flow_cell_mode');
  is ($run_row->rp__workflow_type, 'NovaSeqXp', 'workflow_type');
  is ($run_row->rp__flow_cell_consumable_version, '1',
    'flow_cell_consumable_version');
  is ($run_row->rp__sbs_consumable_version, '3', 'sbs_consumable_version');

  # create a new row
  $schema->resultset('IseqRun')->create(
    {id_run => 46678, id_flowcell_lims => 3567});
  $row = $rs_run_info->update_or_create(
    {id_run => 46678, run_parameters_xml => $contents});
  is ($row->run_parameters_xml, $contents, 'contents is uploaded');
  $run_row = $row->iseq_run();
  is ($run_row->rp__read1_number_of_cycles, 221, 'read1_number_of_cycles');
  is ($run_row->rp__read2_number_of_cycles, 201, 'read2_number_of_cycles');
  is ($run_row->rp__flow_cell_mode, 'SP', 'flow_cell_mode');
  is ($run_row->rp__workflow_type, 'NovaSeqXp', 'workflow_type');
  is ($run_row->rp__flow_cell_consumable_version, '1',
    'flow_cell_consumable_version');
  is ($run_row->rp__sbs_consumable_version, '3', 'sbs_consumable_version');
};

1;
