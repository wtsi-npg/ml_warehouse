use utf8;
package WTSI::DNAP::Warehouse::Schema::Result::Sample;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::Sample

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

=head1 TABLE: C<sample>

=cut

__PACKAGE__->table("sample");

=head1 ACCESSORS

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE

=head2 uuid_sample_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 36

LIMS-specific sample uuid

=head2 id_sample_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

LIMS-specific sample identifier

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of last update

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of sample deletion

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of sample creation

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 reference_genome

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 organism

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 common_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 taxon_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 father

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 mother

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 replicate

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ethnicity

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 gender

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 cohort

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 country_of_origin

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 geographical_region

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 sanger_sample_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 control

  data_type: 'tinyint'
  is_nullable: 1

=head2 supplier_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 public_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 sample_visibility

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 strain

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 consent_withdrawn

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 donor_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id_sample_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "id_lims",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "uuid_sample_lims",
  { data_type => "varchar", is_nullable => 1, size => 36 },
  "id_sample_lims",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "last_updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "recorded_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "deleted_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "reference_genome",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "organism",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "accession_number",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "common_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "taxon_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "father",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "mother",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "replicate",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "ethnicity",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "gender",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "cohort",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "country_of_origin",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "geographical_region",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sanger_sample_id",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "control",
  { data_type => "tinyint", is_nullable => 1 },
  "supplier_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "public_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sample_visibility",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "strain",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "consent_withdrawn",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "donor_id",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_sample_tmp>

=back

=cut

__PACKAGE__->set_primary_key("id_sample_tmp");

=head1 UNIQUE CONSTRAINTS

=head2 C<sample_id_lims_id_sample_lims_index>

=over 4

=item * L</id_lims>

=item * L</id_sample_lims>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "sample_id_lims_id_sample_lims_index",
  ["id_lims", "id_sample_lims"],
);

=head1 RELATIONS

=head2 flgen_plates

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate>

=cut

__PACKAGE__->has_many(
  "flgen_plates",
  "WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate",
  { "foreign.id_sample_tmp" => "self.id_sample_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 iseq_flowcells

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell>

=cut

__PACKAGE__->has_many(
  "iseq_flowcells",
  "WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell",
  { "foreign.id_sample_tmp" => "self.id_sample_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-21 14:51:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sJhsyDV1U388DHEosxbsEg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
