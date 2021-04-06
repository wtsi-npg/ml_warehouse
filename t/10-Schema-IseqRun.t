use strict;
use warnings;
use Test::More tests => 7;
use Test::Exception;

use_ok('WTSI::DNAP::Warehouse::Schema');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
lives_ok { $schema->deploy() } 'schema deployed';

my $rs_run = $schema->resultset('IseqRun');

lives_ok { $rs_run->create({id_run => 34726, folder_name => '34726_RUN_FOLDER_8374', id_flowcell_lims => 3847}) }
	'inserted non-null values';

is_deeply(\{$rs_run->find(34726)->get_columns},
	\{id_run => 34726, folder_name => '34726_RUN_FOLDER_8374', id_flowcell_lims => 3847},
	'retrieved a row');

lives_ok { $rs_run->create({id_run => 80364, id_flowcell_lims => 3}) }
	'inserted null value into folder_name column';

lives_ok { $rs_run->find(80364)->update({folder_name => '80364_RUN_FOLDER_8272', id_flowcell_lims => 8372}) }
	'updated values of a row';
