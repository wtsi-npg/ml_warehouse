
package WTSI::DNAP::Warehouse::Schema::Result::LabwareLocation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::LabwareLocation

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

=head1 TABLE: C<labware_location>

=cut

__PACKAGE__->table('labware_location');

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 labware_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Barcode on the stored labware

=head2 location_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Barcode associated with storage location

=head2 full_location_address

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Fully qualifed address of the nested location

=head2 location_name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 255

Name of location where labware is stored

=head2 coordinate_position

  data_type: 'integer'
  is_nullable: 1

Coordinate position of labware in storage location

=head2 coordinate_row

  data_type: 'integer'
  is_nullable: 1

Coordinate row of labware in storage location

=head2 coordinate_column

  data_type: 'integer'
  is_nullable: 1

Coordinate column of labware in storage location

=head2 lims_id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

ID of the storage system this data comes from

=head2 stored_by

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Username of the person who placed the item there

=head2 stored_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Datetime the item was stored at this location

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  'id',
  { data_type => 'bigint', is_auto_increment => 1, is_nullable => 0 },
  'labware_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'location_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'full_location_address',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'location_name',
  { data_type => 'varchar', default_value => '', is_nullable => 0, size => 255 },
  'coordinate_position',
  { data_type => 'integer', is_nullable => 1 },
  'coordinate_row',
  { data_type => 'integer', is_nullable => 1 },
  'coordinate_column',
  { data_type => 'integer', is_nullable => 1 },
  'lims_id',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'stored_by',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'stored_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'created_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'updated_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key('id');

=head1 UNIQUE CONSTRAINTS

=head2 C<index_labware_location_on_labware_barcode>

=over 4

=item * L</labware_barcode>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'index_labware_location_on_labware_barcode',
  ['labware_barcode'],
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2024-01-19 13:58:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MlRPMXGHbVYnpWjeFULpXQ


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

Copyright (C) 2023 Genome Research Ltd.

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
