
package WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatus

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

=head1 TABLE: C<iseq_run_status>

=cut

__PACKAGE__->table('iseq_run_status');

=head1 ACCESSORS

=head2 id_run_status

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

NPG run identifier

=head2 date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

Status timestamp

=head2 id_run_status_dict

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Status identifier, see iseq_run_status_dict.id_run_status_dict

=head2 id_user

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

Operator usename

=head2 iscurrent

  data_type: 'tinyint'
  is_nullable: 0

Boolean flag, 1 is the status is current, 0 otherwise

=cut

__PACKAGE__->add_columns(
  'id_run_status',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'id_run',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'date',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  'id_run_status_dict',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'id_user',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'iscurrent',
  { data_type => 'tinyint', is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run_status>

=back

=cut

__PACKAGE__->set_primary_key('id_run_status');

=head1 RELATIONS

=head2 run_status_dict

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatusDict>

=cut

__PACKAGE__->belongs_to(
  'run_status_dict',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqRunStatusDict',
  { id_run_status_dict => 'id_run_status_dict' },
  { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-10-28 10:26:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qlGrUJ0M3ve13vAnTd2iJA

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

Copyright (C) 2014 Genome Research Limited

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

