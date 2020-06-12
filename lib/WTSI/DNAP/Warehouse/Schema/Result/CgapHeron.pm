
package WTSI::DNAP::Warehouse::Schema::Result::CgapHeron;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::CgapHeron

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

=head1 TABLE: C<cgap_heron>

=cut

__PACKAGE__->table('cgap_heron');

=head1 ACCESSORS

=head2 cgap_heron_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id. Value can change.

=head2 container_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 tube_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 supplier_sample_id

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 position

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=head2 sample_type

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 release_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 study

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 destination

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 wrangled

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sample_state

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=cut

__PACKAGE__->add_columns(
  'cgap_heron_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'container_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
  'tube_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 32 },
  'supplier_sample_id',
  { data_type => 'varchar', is_nullable => 0, size => 64 },
  'position',
  { data_type => 'varchar', is_nullable => 0, size => 8 },
  'sample_type',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
  'release_time',
  {
    data_type => 'timestamp',
    datetime_undef_if_invalid => 1,
    default_value => '0000-00-00 00:00:00',
    is_nullable => 0,
  },
  'study',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
  'destination',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
  'wrangled',
  {
    data_type => 'timestamp',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'sample_state',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cgap_heron_tmp>

=back

=cut

__PACKAGE__->set_primary_key('cgap_heron_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<cgap_heron_rack_and_position>

=over 4

=item * L</container_barcode>

=item * L</position>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'cgap_heron_rack_and_position',
  ['container_barcode', 'position'],
);

=head2 C<tube_barcode>

=over 4

=item * L</tube_barcode>

=back

=cut

__PACKAGE__->add_unique_constraint('tube_barcode', ['tube_barcode']);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-06-11 17:00:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:w4fgEfecKEbXiTnwlD55lA

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

Copyright (C) 2020 Genome Research Ltd.

This file is part of NPG software, ml_warehouse package
L<https://github.com/wtsi-npg/ml_warehouse>.

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
