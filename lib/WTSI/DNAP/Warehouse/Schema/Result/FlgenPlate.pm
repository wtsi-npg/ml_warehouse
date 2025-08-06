
package WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::FlgenPlate

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

=head1 TABLE: C<flgen_plate>

=cut

__PACKAGE__->table('flgen_plate');

=head1 ACCESSORS

=head2 id_flgen_plate_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_sample_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Sample id, see 'sample.id_sample_tmp'

=head2 id_study_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Study id, see 'study.id_study_tmp'

=head2 cost_code

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Valid WTSI cost code

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of last update

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update

=head2 plate_barcode

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

Manufacturer (Fluidigm) chip barcode

=head2 plate_barcode_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 128

LIMs-specific plate barcode

=head2 plate_uuid_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 36

LIMs-specific plate uuid

=head2 id_flgen_plate_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

LIMs-specific plate id

=head2 plate_size

  data_type: 'smallint'
  is_nullable: 1

Total number of wells on a plate

=head2 plate_size_occupied

  data_type: 'smallint'
  is_nullable: 1

Number of occupied wells on a plate

=head2 well_label

  data_type: 'varchar'
  is_nullable: 0
  size: 10

Manufactuer well identifier within a plate, S001-S192

=head2 well_uuid_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 36

LIMs-specific well uuid

=head2 qc_state

  data_type: 'tinyint'
  is_nullable: 1

QC state; 1 (pass), 0 (fail), NULL (not known)

=cut

__PACKAGE__->add_columns(
  'id_flgen_plate_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'id_sample_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'id_study_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'cost_code',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
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
  'plate_barcode',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'plate_barcode_lims',
  { data_type => 'varchar', is_nullable => 1, size => 128 },
  'plate_uuid_lims',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'id_flgen_plate_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'plate_size',
  { data_type => 'smallint', is_nullable => 1 },
  'plate_size_occupied',
  { data_type => 'smallint', is_nullable => 1 },
  'well_label',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'well_uuid_lims',
  { data_type => 'varchar', is_nullable => 1, size => 36 },
  'qc_state',
  { data_type => 'tinyint', is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_flgen_plate_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_flgen_plate_tmp');

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

=head2 study

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Study>

=cut

__PACKAGE__->belongs_to(
  'study',
  'WTSI::DNAP::Warehouse::Schema::Result::Study',
  { id_study_tmp => 'id_study_tmp' },
  { is_deferrable => 1, on_delete => 'RESTRICT', on_update => 'RESTRICT' },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-10-23 16:35:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lD09a55ctFBQGOiCkQis4Q

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

Copyright (C) 2014,2015,2025 Genome Research Ltd.

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

