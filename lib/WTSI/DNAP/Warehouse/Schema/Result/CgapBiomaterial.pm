
package WTSI::DNAP::Warehouse::Schema::Result::CgapBiomaterial;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::CgapBiomaterial

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

=head1 TABLE: C<cgap_biomaterial>

=cut

__PACKAGE__->table('cgap_biomaterial');

=head1 ACCESSORS

=head2 cgap_biomaterial_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id. Value can change.

=head2 donor_uuid

  data_type: 'varchar'
  is_nullable: 0
  size: 36

=head2 donor_accession_number

  data_type: 'varchar'
  is_nullable: 1
  size: 38

=head2 donor_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 biomaterial_uuid

  data_type: 'varchar'
  is_nullable: 0
  size: 36

=cut

__PACKAGE__->add_columns(
  'cgap_biomaterial_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'donor_uuid',
  { data_type => 'varchar', is_nullable => 0, size => 36 },
  'donor_accession_number',
  { data_type => 'varchar', is_nullable => 1, size => 38 },
  'donor_name',
  { data_type => 'varchar', is_nullable => 1, size => 64 },
  'biomaterial_uuid',
  { data_type => 'varchar', is_nullable => 0, size => 36 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cgap_biomaterial_tmp>

=back

=cut

__PACKAGE__->set_primary_key('cgap_biomaterial_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<biomaterial_uuid>

=over 4

=item * L</biomaterial_uuid>

=back

=cut

__PACKAGE__->add_unique_constraint('biomaterial_uuid', ['biomaterial_uuid']);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-08-19 13:42:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WKpfeiC6T2Ryv16SvVn2sw


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
