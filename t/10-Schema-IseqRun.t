use strict;
use warnings;
use Test::More tests => 6;
use Test::Exception;

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
  
subtest 'create a row' => sub {
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

1;
