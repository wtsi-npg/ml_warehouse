
package WTSI::DNAP::Warehouse::Schema::Result::EseqRun;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::EseqRun

=head1 DESCRIPTION

Information about a run performed on an Element Biosciences instrument derived from instrument output

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

=head1 TABLE: C<eseq_run>

=cut

__PACKAGE__->table('eseq_run');

=head1 ACCESSORS

=head2 id_eseq_run_tmp

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 folder_name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

Run folder name created by the Element Biosciences instrument

=head2 run_name

  data_type: 'varchar'
  is_nullable: 0
  size: 100

Run name as recorded in RunParameters.json file

=head2 flowcell_id

  data_type: 'varchar'
  is_nullable: 0
  size: 100

Flowcell ID as recorded in RunParameters.json file

=head2 run_type

  data_type: 'varchar'
  is_nullable: 1
  size: 100

Run type as recorded in RunParameters.json file

=head2 date_started

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Run date as recorded in RunParameters.json file

=head2 date_completed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

Run completion date from a timestamp of RunUploaded.json file

=head2 run_parameters

  data_type: 'json'
  is_nullable: 0

The content of RunParameters.json file in the run folder

=head2 run_manifest

  data_type: 'json'
  is_nullable: 1

The content of RunManifest.json file in the run folder

=head2 run_stats

  data_type: 'json'
  is_nullable: 1

The content of RunStats.json file produced by bases2fastq

=head2 outcome

  data_type: 'varchar'
  is_nullable: 1
  size: 256

Run outcome as recorded in RunUploaded.json file

=cut

__PACKAGE__->add_columns(
  'id_eseq_run_tmp',
  {
    data_type => 'bigint',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  'folder_name',
  { data_type => 'varchar', is_nullable => 0, size => 200 },
  'run_name',
  { data_type => 'varchar', is_nullable => 0, size => 100 },
  'flowcell_id',
  { data_type => 'varchar', is_nullable => 0, size => 100 },
  'run_type',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'date_started',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'date_completed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  'run_parameters',
  { data_type => 'json', is_nullable => 0 },
  'run_manifest',
  { data_type => 'json', is_nullable => 1 },
  'run_stats',
  { data_type => 'json', is_nullable => 1 },
  'outcome',
  { data_type => 'varchar', is_nullable => 1, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_eseq_run_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_eseq_run_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<eseq_run_fname_unique>

=over 4

=item * L</folder_name>

=back

=cut

__PACKAGE__->add_unique_constraint('eseq_run_fname_unique', ['folder_name']);


# Created by DBIx::Class::Schema::Loader v0.07053 @ 2025-08-15 12:39:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wfeU/Feny4jeA5uXZwylXA

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

Copyright (C) 2025 Genome Research Ltd.

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
