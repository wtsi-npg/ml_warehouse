
package WTSI::DNAP::Warehouse::Schema::Result::BmapFlowcell;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::BmapFlowcell

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

=head1 TABLE: C<bmap_flowcell>

=cut

__PACKAGE__->table('bmap_flowcell');

=head1 ACCESSORS

=head2 id_bmap_flowcell_tmp

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

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

=head2 experiment_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the experiment, eg. The lims generated run id

=head2 instrument_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the instrument on which the sample was run

=head2 enzyme_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

The name of the recognition enzyme used

=head2 chip_barcode

  data_type: 'varchar'
  is_nullable: 0
  size: 255

Manufacturer chip identifier

=head2 chip_serialnumber

  data_type: 'varchar'
  is_nullable: 1
  size: 16

Manufacturer chip identifier

=head2 position

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Flowcell position

=head2 id_flowcell_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 255

LIMs-specific flowcell id

=head2 id_library_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Earliest LIMs identifier associated with library creation

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier

=cut

__PACKAGE__->add_columns(
  'id_bmap_flowcell_tmp',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
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
  'experiment_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'instrument_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'enzyme_name',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'chip_barcode',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'chip_serialnumber',
  { data_type => 'varchar', is_nullable => 1, size => 16 },
  'position',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'id_flowcell_lims',
  { data_type => 'varchar', is_nullable => 0, size => 255 },
  'id_library_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_bmap_flowcell_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_bmap_flowcell_tmp');

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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-06-03 13:17:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zmqIZpa8FZ332Dpr8/dhDw


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

kdj@sanger.ac.uk

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2019 Genome Research Limited

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

