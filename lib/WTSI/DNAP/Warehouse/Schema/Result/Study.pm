
package WTSI::DNAP::Warehouse::Schema::Result::Study;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::Study

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

__PACKAGE__->load_components('InflateColumn::DateTime');

=head1 TABLE: C<study>

=cut

__PACKAGE__->table('study');

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

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of study deletion

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of study creation

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

  data_type: 'tinyint'
  is_nullable: 1

Lane may contain human DNA

=head2 contaminated_human_dna

  data_type: 'tinyint'
  is_nullable: 1

Human DNA in the lane is a contaminant and should be removed

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

=head2 aligned

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

=head2 prelim_id

  data_type: 'varchar'
  is_nullable: 1
  size: 20

The preliminary study id prior to entry into the LIMS

=head2 hmdmc_number

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The Human Materials and Data Management Committee approval number(s) for the study.

=head2 data_destination

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The data destination type(s) for the study. It could be 'standard', '14mg' or 'gseq'. This may be extended, if Sanger gains more external customers. It can contain multiply destinations separated by a space.

=cut

__PACKAGE__->add_columns(
  'id_study_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'uuid_study_lims',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'id_study_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'last_updated',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'recorded_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'deleted_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'created',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'reference_genome',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ethically_approved',
  { data_type => 'tinyint', is_nullable => 1 },
  'faculty_sponsor',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'state',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'study_type',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'abstract',
  { data_type => 'text', is_nullable => 1 },
  'abbreviation',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'description',
  { data_type => 'text', is_nullable => 1 },
  'contains_human_dna',
  { data_type => 'tinyint', is_nullable => 1 },
  'contaminated_human_dna',
  { data_type => 'tinyint', is_nullable => 1 },
  'data_release_strategy',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_sort_of_study',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ena_project_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'study_title',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'study_visibility',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ega_dac_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'array_express_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ega_policy_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_timing',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_delay_period',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_release_delay_reason',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'remove_x_and_autosomes',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'aligned',
  { data_type => 'tinyint', default_value => 1, is_nullable => 0 },
  'separate_y_chromosome_data',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'data_access_group',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'prelim_id',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'hmdmc_number',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'data_destination',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_study_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_study_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<study_id_lims_id_study_lims_index>

=over 4

=item * L</id_lims>

=item * L</id_study_lims>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'study_id_lims_id_study_lims_index',
  ['id_lims', 'id_study_lims'],
);

=head2 C<study_uuid_study_lims_index>

=over 4

=item * L</uuid_study_lims>

=back

=cut

__PACKAGE__->add_unique_constraint('study_uuid_study_lims_index', ['uuid_study_lims']);

=head1 RELATIONS

=head2 flgen_plates

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate>

=cut

__PACKAGE__->has_many(
  'flgen_plates',
  'WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate',
  { 'foreign.id_study_tmp' => 'self.id_study_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 iseq_flowcells

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell>

=cut

__PACKAGE__->has_many(
  'iseq_flowcells',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell',
  { 'foreign.id_study_tmp' => 'self.id_study_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pac_bio_runs

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::PacBioRun>

=cut

__PACKAGE__->has_many(
  'pac_bio_runs',
  'WTSI::DNAP::Warehouse::Schema::Result::PacBioRun',
  { 'foreign.id_study_tmp' => 'self.id_study_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 study_users

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::StudyUser>

=cut

__PACKAGE__->has_many(
  'study_users',
  'WTSI::DNAP::Warehouse::Schema::Result::StudyUser',
  { 'foreign.id_study_tmp' => 'self.id_study_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-19 13:42:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5mBhBEJUs4zksjb1qnrNkw

with 'WTSI::DNAP::Warehouse::Schema::Query::LimsFlags';

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Result class definition in DBIx binding for the multi-lims warehouse database.

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

=item DBIx::Class::InflateColumn::DateTime

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia E<lt>mg8@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2015 Genome Research Limited

This file is part of the ml_warehouse package L<https://github.com/wtsi-npg/ml_warehouse>.

NPG is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut

