use utf8;
package WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell

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

=head1 TABLE: C<iseq_flowcell>

=cut

__PACKAGE__->table("iseq_flowcell");

=head1 ACCESSORS

=head2 id_iseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

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

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Sample id, see "sample.id_sample_tmp"

=head2 id_study_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Study id, see "study.id_study_tmp"

=head2 cost_code

  data_type: 'varchar'
  is_nullable: 1
  size: 20

Valid WTSI cost code

=head2 is_r_and_d

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

A boolean flag derived from cost code, flags RandD

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE

=head2 priority

  data_type: 'smallint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 1

Priority

=head2 manual_qc

  data_type: 'tinyint'
  is_nullable: 1

Manual QC decision, NULL for unknown

=head2 external_release

  data_type: 'tinyint'
  is_nullable: 1

Defaults to manual qc value; can be changed by the user later

=head2 flowcell_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 15

Manufacturer flowcell barcode or other identifier

=head2 id_flowcell_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

LIMs-specific flowcell id, batch_id for Sequencescape

=head2 position

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

Flowcell lane number

=head2 entity_type

  data_type: 'varchar'
  is_nullable: 0
  size: 30

Lane type: library, pool, library_control, library_indexed, library_indexed_spike

=head2 entity_id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Most specific, LIMs identifier associated with this lane or plex or spike

=head2 num_target_components

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

Expected number of targets, one for a non-pool and number of target tags for a pool

=head2 tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Tag index, NULL if lane is not a pool

=head2 tag_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence

=head2 tag_set_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 20

LIMs-specific identifier of the tag set

=head2 tag_set_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

WTSI-wide tag set name

=head2 is_spiked

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

Boolean flag indicating presence of a spike

=head2 pipeline_id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 50

LIMs-specific pipeline identifier that unambiguously defines library type

=head2 bait_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

WTSI-wide name that uniquely identifies a bait set

=head2 requested_insert_size_from

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Requested insert size min value

=head2 requested_insert_size_to

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Requested insert size max value

=head2 forward_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Requested forward read length, bp

=head2 reverse_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Requested reverse read length, bp

=cut

__PACKAGE__->add_columns(
  "id_iseq_flowcell_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
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
  "id_sample_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "id_study_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "cost_code",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "is_r_and_d",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "id_lims",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "priority",
  {
    data_type => "smallint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  "manual_qc",
  { data_type => "tinyint", is_nullable => 1 },
  "external_release",
  { data_type => "tinyint", is_nullable => 1 },
  "flowcell_barcode",
  { data_type => "varchar", is_nullable => 1, size => 15 },
  "id_flowcell_lims",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "position",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 0 },
  "entity_type",
  { data_type => "varchar", is_nullable => 0, size => 30 },
  "entity_id_lims",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "num_target_components",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 0 },
  "tag_index",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "tag_sequence",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "tag_set_id_lims",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "tag_set_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "is_spiked",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "pipeline_id_lims",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "bait_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "requested_insert_size_from",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "requested_insert_size_to",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "forward_read_length",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "reverse_read_length",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_iseq_flowcell_tmp>

=back

=cut

__PACKAGE__->set_primary_key("id_iseq_flowcell_tmp");

=head1 RELATIONS

=head2 id_sample_tmp

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Sample>

=cut

__PACKAGE__->belongs_to(
  "id_sample_tmp",
  "WTSI::DNAP::Warehouse::Schema::Result::Sample",
  { id_sample_tmp => "id_sample_tmp" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 id_study_tmp

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Study>

=cut

__PACKAGE__->belongs_to(
  "id_study_tmp",
  "WTSI::DNAP::Warehouse::Schema::Result::Study",
  { id_study_tmp => "id_study_tmp" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 iseq_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric>

=cut

__PACKAGE__->has_many(
  "iseq_product_metrics",
  "WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric",
  { "foreign.id_iseq_flowcell_tmp" => "self.id_iseq_flowcell_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 iseq_run_lane_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric>

=cut

__PACKAGE__->has_many(
  "iseq_run_lane_metrics",
  "WTSI::DNAP::Warehouse::Schema::Result::IseqRunLaneMetric",
  { "foreign.id_iseq_flowcell_tmp" => "self.id_iseq_flowcell_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-21 14:51:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:434OV3SZJuvxCkoJeAFVmA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
