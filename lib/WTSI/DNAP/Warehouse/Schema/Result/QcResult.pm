
package WTSI::DNAP::Warehouse::Schema::Result::QcResult;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::QcResult

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

=head1 TABLE: C<qc_result>

=cut

__PACKAGE__->table('qc_result');

=head1 ACCESSORS

=head2 id_qc_result_tmp

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 id_qc_result_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

LIMS-specific qc_result identifier

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIMS system identifier (e.g. SEQUENCESCAPE)

=head2 id_pool_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Most specific LIMs identifier associated with the pool. (Asset external_identifier in SS)

=head2 id_library_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Earliest LIMs identifier associated with library creation. (Aliquot external_identifier in SS)

=head2 labware_purpose

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Labware Purpose name. (e.g. Plate Purpose for a Well)

=head2 assay

  data_type: 'varchar'
  is_nullable: 1
  size: 255

assay type and version

=head2 value

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Value of the mesurement

=head2 units

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Mesurement unit

=head2 cv

  data_type: 'float'
  is_nullable: 1

Coefficient of variance

=head2 qc_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Type of mesurement

=head2 date_created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

The date the qc_result was first created in SS

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

The date the qc_result was last updated in SS

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update

=cut

__PACKAGE__->add_columns(
  'id_qc_result_tmp',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'id_qc_result_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'id_pool_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'id_library_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'labware_purpose',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'assay',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'value',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'units',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'cv',
  { data_type => 'float', is_nullable => 1 },
  'qc_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'date_created',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
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
);

=head1 PRIMARY KEY

=over 4

=item * L</id_qc_result_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_qc_result_tmp');

=head1 RELATIONS

=head2 sample

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Sample>

=cut

__PACKAGE__->belongs_to(
  'sample',
  'WTSI::DNAP::Warehouse::Schema::Result::Sample',
  { id_sample_tmp => 'id_sample_tmp' },
  { is_deferrable => 1, on_delete => 'RESTRICT', on_update => 'RESTRICT' },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2018-10-19 16:46:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vkIq07tap5c4gyxr+TtPOQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration

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

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2018 Genome Research Ltd.

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
