
package WTSI::DNAP::Warehouse::Schema::Result::GsuSampleUpload;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::GsuSampleUpload

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

=head1 TABLE: C<gsu_sample_uploads>

=cut

__PACKAGE__->table('gsu_sample_uploads');

=head1 ACCESSORS

=head2 id_gsu_sample_upload_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Row ID

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Datetime this record was created

=head2 last_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Datetime this record was last updated

=head2 file_path

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Location of data file

=head2 id_study_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Study for this item

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Sample info for this item

=head2 library_name

  data_type: 'varchar'
  is_nullable: 1
  size: 40

Supplier library name

=head2 library_type

  data_type: 'varchar'
  is_nullable: 0
  size: 40

Library type

=head2 instrument_model

  data_type: 'varchar'
  is_nullable: 0
  size: 40

Sequencing machine used

=head2 lab_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

Lab supplying the data

=head2 run_accession

  data_type: 'varchar'
  is_nullable: 1
  size: 40

ENA run accession, populated on ENA submission

=head2 ena_upload

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

Identifies if the sample is eligible for ENA upload

=cut

__PACKAGE__->add_columns(
  'id_gsu_sample_upload_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'created',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'last_changed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
  'file_path',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'id_study_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  'library_name',
  { data_type => 'varchar', is_nullable => 1, size => 40 },
  'library_type',
  { data_type => 'varchar', is_nullable => 0, size => 40 },
  'instrument_model',
  { data_type => 'varchar', is_nullable => 0, size => 40 },
  'lab_name',
  { data_type => 'varchar', is_nullable => 0, size => 100 },
  'run_accession',
  { data_type => 'varchar', is_nullable => 1, size => 40 },
  'ena_upload',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_gsu_sample_upload_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_gsu_sample_upload_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<gsu_su_file_path_unq>

=over 4

=item * L</file_path>

=back

=cut

__PACKAGE__->add_unique_constraint('gsu_su_file_path_unq', ['file_path']);

=head2 C<gsu_su_run_accession>

=over 4

=item * L</run_accession>

=back

=cut

__PACKAGE__->add_unique_constraint('gsu_su_run_accession', ['run_accession']);

=head1 RELATIONS

=head2 sample

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Sample>

=cut

__PACKAGE__->belongs_to(
  'sample',
  'WTSI::DNAP::Warehouse::Schema::Result::Sample',
  { id_sample_tmp => 'id_sample_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'RESTRICT',
    on_update     => 'RESTRICT',
  },
);

=head2 study

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Study>

=cut

__PACKAGE__->belongs_to(
  'study',
  'WTSI::DNAP::Warehouse::Schema::Result::Study',
  { id_study_tmp => 'id_study_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'RESTRICT',
    on_update     => 'RESTRICT',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-10-23 16:35:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kLSRN187cu2gr+3cdSypqw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

our $VERSION = '0';

__PACKAGE__->meta->make_immutable;
1;

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

Copyright (C) 2023 Genome Research Limited

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

