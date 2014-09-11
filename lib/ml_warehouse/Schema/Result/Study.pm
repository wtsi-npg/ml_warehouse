use utf8;
package ml_warehouse::Schema::Result::Study;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ml_warehouse::Schema::Result::Study

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

=head1 TABLE: C<study>

=cut

__PACKAGE__->table("study");

=head1 ACCESSORS

=head2 id_study_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier, e.g. GCLP-CLARITY, SEQSCAPE

=head2 uuid_study_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 36

LIMS-specific study uuid

=head2 id_study_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

LIMS-specific study identifier

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of last update

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 reference_genome

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ethically_approved

  data_type: 'tinyint'
  is_nullable: 1

=head2 faculty_sponsor

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 study_type

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 abstract

  data_type: 'text'
  is_nullable: 1

=head2 abbreviation

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 contains_human_dna

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 contaminated_human_dna

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_strategy

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_sort_of_study

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ena_project_id

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 study_title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 study_visibility

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ega_dac_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 array_express_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 ega_policy_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_timing

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_delay_period

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 data_release_delay_reason

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 remove_x_and_autosomes

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 alignments_in_bam

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=head2 separate_y_chromosome_data

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 data_access_group

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id_study_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "id_lims",
  { data_type => "varchar", is_nullable => 0, size => 10 },
  "uuid_study_lims",
  { data_type => "varchar", is_nullable => 1, size => 36 },
  "id_study_lims",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "last_updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "reference_genome",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "ethically_approved",
  { data_type => "tinyint", is_nullable => 1 },
  "faculty_sponsor",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "state",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "study_type",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "abstract",
  { data_type => "text", is_nullable => 1 },
  "abbreviation",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "accession_number",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "contains_human_dna",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "contaminated_human_dna",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "data_release_strategy",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "data_release_sort_of_study",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "ena_project_id",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "study_title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "study_visibility",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "ega_dac_accession_number",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "array_express_accession_number",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "ega_policy_accession_number",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "data_release_timing",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "data_release_delay_period",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "data_release_delay_reason",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "remove_x_and_autosomes",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "alignments_in_bam",
  { data_type => "tinyint", default_value => 1, is_nullable => 0 },
  "separate_y_chromosome_data",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "data_access_group",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_study_tmp>

=back

=cut

__PACKAGE__->set_primary_key("id_study_tmp");

=head1 UNIQUE CONSTRAINTS

=head2 C<study_id_study_lims_index>

=over 4

=item * L</id_study_lims>

=back

=cut

__PACKAGE__->add_unique_constraint("study_id_study_lims_index", ["id_study_lims"]);

=head1 RELATIONS

=head2 flgen_plates

Type: has_many

Related object: L<ml_warehouse::Schema::Result::FlgenPlate>

=cut

__PACKAGE__->has_many(
  "flgen_plates",
  "ml_warehouse::Schema::Result::FlgenPlate",
  { "foreign.id_study_tmp" => "self.id_study_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 iseq_flowcells

Type: has_many

Related object: L<ml_warehouse::Schema::Result::IseqFlowcell>

=cut

__PACKAGE__->has_many(
  "iseq_flowcells",
  "ml_warehouse::Schema::Result::IseqFlowcell",
  { "foreign.id_study_tmp" => "self.id_study_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 study_users

Type: has_many

Related object: L<ml_warehouse::Schema::Result::StudyUser>

=cut

__PACKAGE__->has_many(
  "study_users",
  "ml_warehouse::Schema::Result::StudyUser",
  { "foreign.id_study_tmp" => "self.id_study_tmp" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-09-10 16:38:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hgzxz0vxInfab622jmBdLw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
