
package WTSI::DNAP::Warehouse::Schema::Result::SeqProductIrodsLocation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::SeqProductIrodsLocation - Table relating products to their irods locations

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

=head1 TABLE: C<seq_product_irods_locations>

=cut

__PACKAGE__->table('seq_product_irods_locations');

=head1 ACCESSORS

=head2 id_seq_product_irods_locations_tmp

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

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

Datetime this record was created or changed

=head2 id_product

  data_type: 'varchar'
  is_nullable: 0
  size: 64

Product id, maps to value in product metrics table, such as id_iseq_product in iseq_product_metrics

=head2 seq_platform_name

  data_type: 'enum'
  extra: {list => ['Illumina','PacBio','ONT']}
  is_nullable: 0

Name of the sequencing platform used to produce raw data

=head2 pipeline_name

  data_type: 'varchar'
  is_nullable: 0
  size: 32

The name of the pipeline used to produce the data, values are: npg-prod, npg-prod-alt-process, cellranger, spaceranger, ncov2019-artic-nf

=head2 irods_root_collection

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Path to the product root collection in iRODS

=head2 irods_data_relative_path

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The path, relative to the root collection, to the most used data location

=head2 irods_secondary_data_relative_path

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The path, relative to the root collection, to a useful data location

=cut

__PACKAGE__->add_columns(
  'id_seq_product_irods_locations_tmp',
  {
    data_type => 'bigint',
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
  'id_product',
  { data_type => 'varchar', is_nullable => 0, size => 64 },
  'seq_platform_name',
  {
    data_type => 'enum',
    extra => { list => ['Illumina', 'PacBio', 'ONT'] },
    is_nullable => 0,
  },
  'pipeline_name',
  { data_type => 'varchar', is_nullable => 0, size => 32 },
  'irods_root_collection',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'irods_data_relative_path',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'irods_secondary_data_relative_path',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_seq_product_irods_locations_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_seq_product_irods_locations_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<pi_root_product>

=over 4

=item * L</irods_root_collection>

=item * L</id_product>

=back

=cut

__PACKAGE__->add_unique_constraint('pi_root_product', ['irods_root_collection', 'id_product']);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-08-25 16:46:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hcVgom+GpJNV7+hBSlE9Sg


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
