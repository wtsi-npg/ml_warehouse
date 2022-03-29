use strict;
use warnings;
use Test::More tests => 9;
use Test::Exception;
use Test::Warn;
use Perl6::Slurp;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Result::IseqRun');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema
                     ->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
lives_ok { $schema->deploy() } 'schema deployed';

my $rs_run = $schema->resultset('IseqRun');

subtest 'create a row' => sub {
  plan tests => 16;

  my $data = {id_run => 45678};
  lives_ok { $rs_run->create($data) } 
    'create a row with both flowcell id and run folder undefined';
  my $row = $rs_run->find($data->{id_run});
  is ($row->folder_name, undef, 'folder name is undefined');
  is ($row->id_flowcell_lims, undef, 'flowcell id is undefined'); 
  
  $data = {
    id_run => 34726,
    folder_name => '34726_RUN_FOLDER_8374',
    id_flowcell_lims => 3847
  };
  lives_ok { $rs_run->create($data) }
    'create a row with the folder name and flowcell id defined';
  $row = $rs_run->find($data->{id_run});
  is ($row->id_flowcell_lims, $data->{id_flowcell_lims}, 'flowcell id is correct');
  is ($row->folder_name, $data->{folder_name}, 'folder name is correct');
  
  $data = {id_run => 80364, id_flowcell_lims => 3};
  lives_ok { $rs_run->create($data) }
    'create a row with a null value in the folder_name column';
  $row = $rs_run->find($data->{id_run});
  is ($row->id_flowcell_lims, 3, 'flowcell id is correct');
  is ($row->folder_name, undef, 'folder name is undefined');
  
  lives_ok { $row->update(
    {folder_name => '80364_RUN_FOLDER_8272', id_flowcell_lims => 8372}) }
    'updated values for a row';
  is ($row->id_flowcell_lims, 8372, 'flowcell id is correct');
  is ($row->folder_name, '80364_RUN_FOLDER_8272',
    'folder name is defined and correct');
  
  lives_ok { $row->update({id_flowcell_lims => 3}) }
    'use existing flowcell id in an update';
  is ($row->id_flowcell_lims, 3, 'flowcell id is updated');
  
  lives_ok { $row->update({folder_name => '34726_RUN_FOLDER_8374'}) }
    'use existing folder name in an update';
  is ($row->folder_name, '34726_RUN_FOLDER_8374', 'folder name is updated');
};
  
subtest 'generate mapping' => sub {
  plan tests => 3;

  my $map = {};
  $map->{rp} = {
    FlowCellMode         => 'rp__flow_cell_mode',
    FlowCellConsumableVersion => 'rp__flow_cell_consumable_version',
    SbsConsumableVersion => 'rp__sbs_consumable_version',
    WorkflowType         => 'rp__workflow_type',
    Read1NumberOfCycles  => 'rp__read1_number_of_cycles',
    Read2NumberOfCycles  => 'rp__read2_number_of_cycles'
  };

  my $row = $rs_run->find(80364);
  is_deeply ($row->get_column_names_map(), $map, 'mapping of names is correct');

  $map = {
    flowCellMode          => 'rp_flow_cell_mode',
    Read1NumberOfCycles   => 'rp__read1_number_of_cycles',
    '2readNumberOfCycles' => 'rp_2read_number_of_cycles',
  };
  is_deeply ($row->_generate_map('rp', values %{$map}), $map,
    'mapping of names is correct');

  my $class = $rs_run->result_class();
  is_deeply ($class->_generate_map('rp', values %{$map}), $map,
    'mapping of names is correct - class method');
};

subtest 'test relation to iseq_run_info' => sub {
  plan tests => 4;

  my $row = $rs_run->find(80364);
  is ($row->iseq_run_info(), undef, 'no related row');

  my $string = <<'SIMPLE'
<?xml version="1.0"?>
<RunParameters/>
SIMPLE
;

  $schema->resultset('IseqRunInfo')->create(
    {id_run => 80364, run_parameters_xml => $string});
  my $related = $row->iseq_run_info();
  is (ref $related, 'WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo',
   'relation returns a row');
  is ($related->id_run, 80364, 'correct run id');
  is ($related->run_parameters_xml, $string, 'file content');
};

subtest 'parse run params., load the values' => sub {
  plan tests => 22;

  my $row = $rs_run->find(80364);
  
  throws_ok { $row->update_values_from_xml() }
    qr/No mapping is available for file type 'unknown'/,
    'no arguments - error';
  throws_ok { $row->update_values_from_xml('ri') }
    qr/No mapping is available for file type 'ri'/,
    'unknown file type - error';
  
  my $updated;
  warning_like { $updated = $row->update_values_from_xml('rp', 'some') }
    qr/Error extracting or populating values for run parameters/,
    'parsing error is emitted as a warning';
  is ($updated, 0, 'row is not updated');
  
  my $string = <<'FILE_END'
<?xml version="1.0"?>
<RunParameters xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <setup/>
</RunParameters>
FILE_END
;

  lives_ok { $updated = $row->update_values_from_xml('rp', $string) }
    'XML elements with the names we look for are not preset - no error';
  is ($updated, 0, 'row is not updated');

  # Test run params. files for different instrument types.
  # At the moment the elements we look for are present in files for
  # NovaSeq instruments only.
  my @file_names = qw/runParameters_HiSeq.xml runParameters_HiSeqX.xml
                      RunParameters_MiSeq.xml runParameters_HiSeq4000.xml/;

  for my $name (@file_names) {
    my $contents = slurp "t/data/run_params/$name";
    lives_ok { $updated = $row->update_values_from_xml('rp', $contents) }
      "no error for $name";
    is ($updated, 0, "$name - row is not updated");
  }

  my $name = 'RunParameters_NovaSeq.xml';
  my $contents = slurp "t/data/run_params/$name";
  lives_ok { $updated = $row->update_values_from_xml('rp', $contents) }
    "no error for $name";
  is ($updated, 1, "$name - row is updated");
  is ($row->rp__read1_number_of_cycles, 221, 'read1_number_of_cycles');
  is ($row->rp__read2_number_of_cycles, 201, 'read2_number_of_cycles');
  is ($row->rp__flow_cell_mode, 'SP', 'flow_cell_mode');
  is ($row->rp__workflow_type, 'NovaSeqXp', 'workflow_type');
  is ($row->rp__flow_cell_consumable_version, '1', 'flow_cell_consumable_version');
  is ($row->rp__sbs_consumable_version, '3', 'sbs_consumable_version');
};
 
subtest 'parse run params., load the values - edge cases' => sub {
  plan tests => 13;

  my $string = <<'FILE_END'
<?xml version="1.0"?>
<RunParameters>
  <Read1NumberOfCycles>some</Read1NumberOfCycles>
  <Read2NumberOfCycles>0</Read2NumberOfCycles>
  <FlowCellMode/>
  <WorkflowType>Standard</WorkflowType>
  <SbsConsumableVersion>5.8</SbsConsumableVersion>
</RunParameters>
FILE_END
;

  my $row = $rs_run->find(45678);
  my $updated = $row->update_values_from_xml('rp', $string);
  is ($updated, 1, 'the row is updated');
  is ($row->rp__read1_number_of_cycles, undef,
    'read1_number_of_cycles - float value is not loaded');
  is ($row->rp__read2_number_of_cycles, 0,
    'read2_number_of_cycles - zero value is loaded');
  is ($row->rp__flow_cell_mode, undef,
    'flow_cell_mode remains undefined since the element contains no value');
  is ($row->rp__workflow_type, 'Standard', 'workflow_type is loaded');
  is ($row->rp__sbs_consumable_version, '5.8',
    'sbs_consumable_version is loaded as a string representing a float value');

  $string = <<'FILE_END'
<?xml version="1.0"?>
<RunParameters>
  <Read1NumberOfCycles>7.9</Read1NumberOfCycles>
  <Read2NumberOfCycles>0</Read2NumberOfCycles>
  <FlowCellMode>SP</FlowCellMode>
  <WorkflowType>Standard</WorkflowType>
  <SbsConsumableVersion>5.8</SbsConsumableVersion>
</RunParameters>
FILE_END
;

  $updated = $row->update_values_from_xml('rp', $string);
  is ($updated, 1, 'the row is updated');
  is ($row->rp__read1_number_of_cycles, 7,
    'read1_number_of_cycles - float value is truncated to int');
  is ($row->rp__read2_number_of_cycles, 0,
    'read2_number_of_cycles - zero value is loaded');
  is ($row->rp__flow_cell_mode, 'SP',
    'flow_cell_mode value is loaded');
  is ($row->rp__workflow_type, 'Standard', 'workflow_type is loaded');
  is ($row->rp__sbs_consumable_version, '5.8',
    'sbs_consumable_version is loaded as a string representing a float value');
  
  $updated = $row->update_values_from_xml('rp', $string);
  is ($updated, 1, 'the row is considered as updated');
};

1;
