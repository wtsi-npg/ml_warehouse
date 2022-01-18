
package WTSI::DNAP::Warehouse::Schema::Result::PsdSampleCompoundsComponent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::PsdSampleCompoundsComponent

=head1 DESCRIPTION

A join table owned by PSD to associate compound samples with their component samples.

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

=head1 TABLE: C<psd_sample_compounds_components>

=cut

__PACKAGE__->table('psd_sample_compounds_components');

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 compound_id_sample_tmp

  data_type: 'integer'
  is_nullable: 0

The warehouse ID of the compound sample in the association.

=head2 component_id_sample_tmp

  data_type: 'integer'
  is_nullable: 0

The warehouse ID of the component sample in the association.

=head2 last_updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of last update.

=head2 recorded_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Timestamp of warehouse update.

=cut

__PACKAGE__->add_columns(
  'id',
  { data_type => 'bigint', is_auto_increment => 1, is_nullable => 0 },
  'compound_id_sample_tmp',
  { data_type => 'integer', is_nullable => 0 },
  'component_id_sample_tmp',
  { data_type => 'integer', is_nullable => 0 },
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
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key('id');


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-01-18 09:43:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jQ0yBDxbPIV7ZTXayP+00g

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

Copyright (C) 2022 Genome Research Ltd.

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

