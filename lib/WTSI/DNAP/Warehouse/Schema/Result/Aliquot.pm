
package WTSI::DNAP::Warehouse::Schema::Result::Aliquot;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::Aliquot

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

=head1 TABLE: C<aliquot>

=cut

__PACKAGE__->table('aliquot');

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The LIMS system that the aliquot was created in

=head2 aliquot_uuid

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The UUID of the aliquot in the LIMS system

=head2 aliquot_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The type of the aliquot

=head2 source_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The type of the source of the aliquot

=head2 source_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The barcode of the source of the aliquot

=head2 sample_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the sample that the aliquot was created from

=head2 used_by_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The type of the entity that the aliquot is used by

=head2 used_by_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The barcode of the entity that the aliquot is used by

=head2 volume

  data_type: 'decimal'
  is_nullable: 0
  size: [10,2]

The volume of the aliquot (uL)

=head2 concentration

  data_type: 'decimal'
  is_nullable: 1
  size: [10,2]

The concentration of the aliquot (ng/ul)

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

The date and time that the aliquot was last updated

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

The date and time that the aliquot was recorded

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

The date and time that this record was created

=head2 insert_size

  data_type: 'integer'
  is_nullable: 1

The size of the insert in base pairs

=cut

__PACKAGE__->add_columns(
  'id',
  { data_type => 'bigint', is_auto_increment => 1, is_nullable => 0 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'aliquot_uuid',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'aliquot_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'source_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'source_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'sample_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'used_by_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'used_by_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'volume',
  { data_type => 'decimal', is_nullable => 0, size => [10, 2] },
  'concentration',
  { data_type => 'decimal', is_nullable => 1, size => [10, 2] },
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
  'created_at',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'insert_size',
  { data_type => 'integer', is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key('id');


# Created by DBIx::Class::Schema::Loader v0.07052 @ 2024-12-18 10:40:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:THzPpPHEAv/8hWXfw77wsw

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

Copyright (C) 2024 Genome Research Ltd.

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
