use utf8;
package WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus

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

=head1 TABLE: C<iseq_run_status>

=cut

__PACKAGE__->table("iseq_run_status");

=head1 ACCESSORS

=head2 id_run_status

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

NPG run identifier

=head2 date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Status timestamp

=head2 id_run_status_dict

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Status identifier, see iseq_run_status_dict.id_run_status_dict

=head2 id_user

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

Operator usename

=head2 iscurrent

  data_type: 'tinyint'
  is_nullable: 0

Boolean flag, 1 is the status is current, 0 otherwise

=cut

__PACKAGE__->add_columns(
  "id_run_status",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "id_run",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "id_run_status_dict",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "id_user",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "iscurrent",
  { data_type => "tinyint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run_status>

=back

=cut

__PACKAGE__->set_primary_key("id_run_status");

=head1 RELATIONS

=head2 id_run_status_dict

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatusDict>

=cut

__PACKAGE__->belongs_to(
  "id_run_status_dict",
  "WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatusDict",
  { id_run_status_dict => "id_run_status_dict" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-21 14:51:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MPbVh6leazW3aSsjNd/eTw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
