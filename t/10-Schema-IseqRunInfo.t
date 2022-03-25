use strict;
use warnings;
use Test::More tests => 5;
use Test::Exception;

use_ok('WTSI::DNAP::Warehouse::Schema');
use_ok('WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo');

my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema
                     ->connect('dbi:SQLite:dbname=:memory:') }
  'connected to test in-memory database';
lives_ok { $schema->deploy() } 'schema deployed';

my $rs_run_info = $schema->resultset('IseqRunInfo');

subtest 'create a row' => sub {
  plan tests => 6;

  my $data = {id_run => 45678};
  lives_ok { $rs_run_info->create($data) } 
    'create a row with run params data undefined';
  my $row = $rs_run_info->find($data->{id_run});
  is ($row->run_parameters_xml, undef, 'run params data is undefined');
  $row->update({run_parameters_xml => 'fffffff'});
  is ($row->run_parameters_xml, 'fffffff', 'run params. is correctly updated');
  
  $data->{run_parameters_xml} = 'tyuuuuuu';
  throws_ok { $rs_run_info->create($data) }
    qr/UNIQUE constraint failed/,
    'Cannot create a row with the run id of the existing row';

  $data = {id_run => 45679, run_parameters_xml => 'sddsdsd'};
  lives_ok { $rs_run_info->create($data) }
    'create a row with run params data undefined';
  $row = $rs_run_info->find($data->{id_run});
  is ($row->run_parameters_xml, 'sddsdsd', 'run params data'); 
};

1;
