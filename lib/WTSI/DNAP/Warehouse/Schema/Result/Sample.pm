
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

__PACKAGE__->load_components('InflateColumn::DateTime');

=head1 TABLE: C<sample>

=cut

__PACKAGE__->table('sample');

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
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'uuid_sample_lims',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'id_sample_lims',
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
  'organism',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'common_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'description',
  { data_type => 'text', is_nullable => 1 },
  'taxon_id',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'father',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'mother',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'replicate',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'ethnicity',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'gender',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'cohort',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'country_of_origin',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'geographical_region',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sanger_sample_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'control',
  { data_type => 'tinyint', is_nullable => 1 },
  'supplier_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'public_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'sample_visibility',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'strain',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'consent_withdrawn',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'donor_id',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_sample_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_sample_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<index_sample_on_id_sample_lims_and_id_lims>

=over 4

=item * L</id_sample_lims>

=item * L</id_lims>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_sample_on_id_sample_lims_and_id_lims',
  ['id_sample_lims', 'id_lims'],
);

=head2 C<sample_uuid_sample_lims_index>

=over 4

=item * L</uuid_sample_lims>

=back

=cut

__PACKAGE__->add_unique_constraint('sample_uuid_sample_lims_index', ['uuid_sample_lims']);

=head1 RELATIONS

=head2 flgen_plates

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate>

=cut

__PACKAGE__->has_many(
  'flgen_plates',
  'WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate',
  { 'foreign.id_sample_tmp' => 'self.id_sample_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 iseq_flowcells

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell>

=cut

__PACKAGE__->has_many(
  'iseq_flowcells',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell',
  { 'foreign.id_sample_tmp' => 'self.id_sample_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 pac_bio_runs

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::PacBioRun>

=cut

__PACKAGE__->has_many(
  'pac_bio_runs',
  'WTSI::DNAP::Warehouse::Schema::Result::PacBioRun',
  { 'foreign.id_sample_tmp' => 'self.id_sample_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2016-01-25 14:58:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R3kVhfDKX/dE0+rn/ALdGg

our $VERSION = '0';

with 'WTSI::DNAP::Warehouse::Schema::Query::LimsFlags';

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
