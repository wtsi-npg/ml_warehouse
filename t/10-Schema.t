use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;
use File::Temp qw(tempdir);
use File::Spec::Functions;

use_ok('WTSI::DNAP::Warehouse::Schema');

my $db = catfile(tempdir(CLEANUP => 1,), 'test.db');
diag "sqlite test db location: $db";
my $schema;
lives_ok { $schema = WTSI::DNAP::Warehouse::Schema->connect('dbi:SQLite:'.$db) }
  'connected to test database';
isa_ok ($schema, 'WTSI::DNAP::Warehouse::Schema');
lives_ok { $schema->deploy() } 'schema deployed';

1;
