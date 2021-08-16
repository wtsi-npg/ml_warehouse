
package WTSI::DNAP::Warehouse::Schema::Result::ProductIrod;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::ProductIrod

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

=head1 TABLE: C<product_irods>

=cut

__PACKAGE__->table('product_irods');

=head1 ACCESSORS

=head2 id_product_irods_tmp

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

ID internal to this database

=head2 id_product

  data_type: 'varchar'
  is_nullable: 0
  size: 64

Product id

=head2 platform_name

  data_type: 'enum'
  extra: {list => ['illumina','pacbio','ont']}
  is_nullable: 0

Name of the platform used to produce raw data

=head2 analysis_type

  data_type: 'enum'
  extra: {list => ['original','alt_process','10x','artic']}
  is_nullable: 0

The type of analysis used

=head2 irods_root

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Path to the product root in iRODS

=head2 irods_data

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The most accessed data path as provided by the customer

=head2 irods_secondary_data

  data_type: 'varchar'
  is_nullable: 1
  size: 255

A secondary data path as provided by the customer

=cut

__PACKAGE__->add_columns(
  'id_product_irods_tmp',
  {
    data_type => 'bigint',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_product',
  { data_type => 'varchar', is_nullable => 0, size => 64 },
  'platform_name',
  {
    data_type => 'enum',
    extra => { list => ['illumina', 'pacbio', 'ont'] },
    is_nullable => 0,
  },
  'analysis_type',
  {
    data_type => 'enum',
    extra => { list => ['original', 'alt_process', '10x', 'artic'] },
    is_nullable => 0,
  },
  'irods_root',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'irods_data',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'irods_secondary_data',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_product_irods_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_product_irods_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<pi_irods_root>

=over 4

=item * L</irods_root>

=back

=cut

__PACKAGE__->add_unique_constraint('pi_irods_root', ['irods_root']);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-08-13 14:24:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vDYuXlnMcHG6f7u5GlOTBg


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

Michael Kubiak E<lt>mk35@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2021 Genome Research Limited

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

