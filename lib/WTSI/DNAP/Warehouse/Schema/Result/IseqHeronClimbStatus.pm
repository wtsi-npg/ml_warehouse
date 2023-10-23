
package WTSI::DNAP::Warehouse::Schema::Result::IseqHeronClimbStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqHeronClimbStatus

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

=head1 TABLE: C<iseq_heron_climb_status>

=cut

__PACKAGE__->table('iseq_heron_climb_status');

=head1 ACCESSORS

=head2 id_iseq_product

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 supplier_sample_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 climb_upload

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 folder_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 climb_biosample_metadata_upload

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 cog_sample_meta

  data_type: 'tinyint'
  is_nullable: 1

=head2 climb_sequence_metadata_upload

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 anonymous_sample_id

  data_type: 'varchar'
  is_nullable: 1
  size: 15

=cut

__PACKAGE__->add_columns(
  'id_iseq_product',
  { data_type => 'char', is_nullable => 1, size => 64 },
  'supplier_sample_name',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'climb_upload',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'folder_name',
  { data_type => 'varchar', is_nullable => 1, size => 64 },
  'climb_biosample_metadata_upload',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'cog_sample_meta',
  { data_type => 'tinyint', is_nullable => 1 },
  'climb_sequence_metadata_upload',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'id',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'anonymous_sample_id',
  { data_type => 'varchar', is_nullable => 1, size => 15 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key('id');


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-10-23 16:35:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3XOtKycEV9IycXJtXeepZQ


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
