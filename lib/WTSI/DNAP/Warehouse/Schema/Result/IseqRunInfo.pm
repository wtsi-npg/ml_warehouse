
package WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo - Table storing selected text files from the run folder

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

=head1 TABLE: C<iseq_run_info>

=cut

__PACKAGE__->table('iseq_run_info');

=head1 ACCESSORS

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

NPG run identifier

=head2 run_parameters_xml

  data_type: 'text'
  is_nullable: 1

The contents of Illumina's {R,r}unParameters.xml file

=cut

__PACKAGE__->add_columns(
  'id_run',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  'run_parameters_xml',
  { data_type => 'text', is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run>

=back

=cut

__PACKAGE__->set_primary_key('id_run');

=head1 RELATIONS

=head2 run

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRun>

=cut

__PACKAGE__->belongs_to(
  'run',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqRun',
  { id_run => 'id_run' },
  { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-04-01 17:33:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dboQ2bkPkWQ+PRCfjf/+0A


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use Carp;
use Try::Tiny;

our $VERSION = '0';

around [qw/update insert/] => sub {
  my $orig = shift;
  my $self = shift;
  my @values = @_;

  try {
    my $rp_xml = $values[0]->{run_parameters_xml} || $self->run_parameters_xml();
    my $id_run = $values[0]->{id_run} || $self->id_run();
    $self->result_source->schema->txn_do( sub {
      my $run_row = $self->run();
      if (not $run_row) { # Create a rudimentary (id_run only) parent row.
        carp "iseq_run table: no data for run $id_run, will create a row";
        $run_row = $self->result_source->resultset
          ->related_resultset('run')->create({id_run => $id_run});
      }
      # Parse XML and populate individual columns in iseq_run.
      if ($rp_xml) {
        $run_row->update_values_from_xml('rp', $rp_xml);
      }
    });
  } catch {
    croak 'update or insert operation will not be performed: ' . $_;
  };

  # Now sure why, but the original method cannot be invoked within
  # the above transaction.

  return $self->$orig(@_);
};

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head2 update

The parent's method is extended to parse the contents of the 
C<run_parameters_xml> column and populate relevant columns in
the C<iseq_run> table. If the parent record in the C<iseq_run>
does not exist, it will be created.

=head2 insert

The parent's method is extended to parse the contents of the 
C<run_parameters_xml> column and populate relevant columns in
the C<iseq_run> table. If the parent record in the C<iseq_run>
table does not exist, it will be created.

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Carp

=item Try::Tiny

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
