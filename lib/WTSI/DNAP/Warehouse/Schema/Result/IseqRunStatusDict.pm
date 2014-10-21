use utf8;
package WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatusDict;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatusDict

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<iseq_run_status_dict>

=cut

__PACKAGE__->table("iseq_run_status_dict");

=head1 ACCESSORS

=head2 id_run_status_dict

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 iscurrent

  data_type: 'tinyint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 temporal_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id_run_status_dict",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "iscurrent",
  { data_type => "tinyint", extra => { unsigned => 1 }, is_nullable => 0 },
  "temporal_index",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run_status_dict>

=back

=cut

__PACKAGE__->set_primary_key("id_run_status_dict");

=head1 RELATIONS

=head2 iseq_run_statuses

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus>

=cut

__PACKAGE__->has_many(
  "iseq_run_statuses",
  "WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus",
  { "foreign.id_run_status_dict" => "self.id_run_status_dict" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-21 14:51:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:z/5QRTnUe3GJhDQry8GOcg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
