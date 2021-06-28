
package WTSI::DNAP::Warehouse::Schema::Result::SamplesExtractionActivity;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::SamplesExtractionActivity

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

=head1 TABLE: C<samples_extraction_activity>

=cut

__PACKAGE__->table('samples_extraction_activity');

=head1 ACCESSORS

=head2 id_activity_tmp

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_activity_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 255

LIMs-specific activity id

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Sample id, see 'sample.id_sample_tmp'

=head2 activity_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The type of the activity performed

=head2 instrument

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the instrument used to perform the activity

=head2 kit_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The barcode of the kit used to perform the activity

=head2 kit_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The type of kit used to perform the activity

=head2 input_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The barcode of the labware (eg. plate or tube) at the begining of the activity

=head2 output_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The barcode of the labware (eg. plate or tube)  at the end of the activity

=head2 user

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the user who was most recently associated with the activity

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of last change to activity

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update

=head2 completed_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of activity completion

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Timestamp of any activity removal

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier

=cut

__PACKAGE__->add_columns(
  'id_activity_tmp',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
  'id_activity_lims',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'activity_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'instrument',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'kit_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'kit_type',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'input_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'output_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'user',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
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
  'completed_at',
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
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_activity_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_activity_tmp');

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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-06-29 10:33:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GdxAgnB+5z2/MW2ftwEJkA

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

Copyright (C) 2021 Genome Research Ltd.

This file is part of the ml_warehouse package
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
