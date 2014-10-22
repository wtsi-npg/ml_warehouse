use utf8;
package WTSI::DNAP::Warehouse::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-21 14:51:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AFE7Lb/gMIr+NG9Q+5SozA

with 'npg_tracking::util::db_connect' if eval "require npg_tracking::util::db_connect";

__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
