
package WTSI::DNAP::Warehouse::Schema::Result::IseqRun;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqRun

=head1 DESCRIPTION

Table linking run and flowcell identities with the run folder name

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

=head1 TABLE: C<iseq_run>

=cut

__PACKAGE__->table('iseq_run');

=head1 ACCESSORS

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

NPG run identifier

=head2 id_flowcell_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 20

LIMS specific flowcell id

=head2 folder_name

  data_type: 'varchar'
  is_nullable: 1
  size: 64

Runfolder name

=head2 rp__read1_number_of_cycles

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Read 1 number of cycles

=head2 rp__read2_number_of_cycles

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Read 2 number of cycles

=head2 rp__flow_cell_mode

  data_type: 'varchar'
  is_nullable: 1
  size: 4

Flowcell mode

=head2 rp__workflow_type

  data_type: 'varchar'
  is_nullable: 1
  size: 12

Workflow type

=head2 rp__flow_cell_consumable_version

  data_type: 'varchar'
  is_nullable: 1
  size: 4

Flowcell consumable version

=head2 rp__sbs_consumable_version

  data_type: 'varchar'
  is_nullable: 1
  size: 4

Sbs consumable version

=cut

__PACKAGE__->add_columns(
  'id_run',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 0 },
  'id_flowcell_lims',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'folder_name',
  { data_type => 'varchar', is_nullable => 1, size => 64 },
  'rp__read1_number_of_cycles',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'rp__read2_number_of_cycles',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'rp__flow_cell_mode',
  { data_type => 'varchar', is_nullable => 1, size => 4 },
  'rp__workflow_type',
  { data_type => 'varchar', is_nullable => 1, size => 12 },
  'rp__flow_cell_consumable_version',
  { data_type => 'varchar', is_nullable => 1, size => 4 },
  'rp__sbs_consumable_version',
  { data_type => 'varchar', is_nullable => 1, size => 4 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_run>

=back

=cut

__PACKAGE__->set_primary_key('id_run');

=head1 RELATIONS

=head2 iseq_run_info

Type: might_have

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo>

=cut

__PACKAGE__->might_have(
  'iseq_run_info',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqRunInfo',
  { 'foreign.id_run' => 'self.id_run' },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2022-03-31 11:47:30
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BjszN3SUdgRos/duK+m4Uw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

use XML::LibXML;
use Try::Tiny;
use Carp;

our $VERSION = '0';

sub get_column_names_map {

  my @rp_column_names = grep { m{\Arp_}smx } __PACKAGE__->columns();
  my $map = {};
  my $prefix = 'rp';
  $map->{$prefix} = __PACKAGE__->_generate_map($prefix, @rp_column_names);

  return $map;
}

sub update_values_from_xml {
  my ($self, $file_type, $string_xml) = @_;

  $file_type ||= q[unknown];
  my $map = $self->get_column_names_map()->{$file_type};
  if (not $map) {
    croak "No mapping is available for file type '$file_type'";
  }

  my $update = 0;
  if (defined $string_xml) {
    try {
      my $doc = XML::LibXML->load_xml(string => $string_xml);
      my $values = {};
      while (my ($element_name, $column_name) = each %{$map}) {
        my $value = $doc->find(qq(//$element_name)); #XPath expression
        if (defined $value and $value ne q[]) {
          if ($column_name =~ /number_of_cycles/xms) {
            # If $value does not represent a number, we will get zero.
            # Zero is a  legitimate value, so we have to try to figure
            # out whether in this case it's an artefact of casting.
            my $original_value = $value;
            $value = int $value;
            if ($value == 0 and $original_value ne q[0]) {
              next; # Casting artefact, will not load.
            }
            # If, however, $value does represent a number, but the number
            # is not an integer, we will use whatever the int() function
            # returns.
          }
          $values->{$column_name} = $value;
        }
      }
      if (keys %{$values}) {
        $self->update($values);
        $update = 1;
      }
    } catch {
      croak "Error extracting or populating values for run parameters: $_";
    };
  }

  return $update;
}

sub _generate_map {
  my ($package, $prefix, @column_names) = @_;

  my $map = {};
  $prefix = $prefix . q[_];
  for my $column_name (@column_names) {
    my $name = $column_name;
    $name =~ s/\A$prefix//smx;
    my @words = split /_/smx, $name;
    my $element_name = join q[], map { ucfirst } @words;
    if ($words[0] ne q[]) { # no leading underscore
      $element_name = lcfirst $element_name;
    }
    $map->{$element_name} = $column_name;
  }

  return $map;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 SYNOPSIS

This DBIx class links run and flowcell identities with the run folder name.

It also provides access to selected values from Illumina's files, which
capture the settings for the run. The table columns starting from C<rp_>
contain values from the C<{R,n}unParameters.xml> file. The full contents of
the file is available in the C<iseq_run_info> table.

The column names are derived from the names of XML elements using a simple
rule: the names are converted to lower case and the underscore is inserted
in front of what is a capital letter in the element name. This is done in
order to mitigate the fact that the column names in MySQL are case insensitive,
while XML element names and most XML parsers are case sensitive.

Thus the  C<rp__read1_number_of_cycles> column display data from this

  <Read1NumberOfCycles>100</Read1NumberOfCycles>

fragment of the C<{R,n}unParameters.xml> file.

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head2 get_column_names_map

Returns a hash reference mapping names of the XML elements to column names.
Element names from the C<{R,n}unParameters.xml> file are mapped under the
C<rp> key. This is a package-level method. It can also be called on an
instance of a row.

  my $rp_map = __PACKAGE__->get_column_names_map()->{'rp'};
  for my $ename (keys %{$rp_map}) {
    print "XML element $ename maps to column " . $rp_map->{$ename} . "\n"; 
  }    

=head2 update_values_from_xml

Parses input XML data, extracts the values that can be loaded
to columns of this table.

  my $updated = $row->update_values_from_xml('rp', $run_param_xml);

The above invocation instructs this method to load columns with names
starting with C<rp_>. The second argument shoudl be a string representing
valid XML.

The return value is 1 if some data from the input XML string correspond to
columns to be loaded, 0 if no eligible data is found. The return value of
1 does not indicate that the values in the row have been changed. The return
value of 0 means that the C<update> database operation has not been called.

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item DBIx::Class::Core

=item DBIx::Class::InflateColumn::DateTime

=item XML::LibXML

=item Try::Tiny

=item Carp

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Michael Kubiak E<lt>mk35@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2021, 2022 Genome Research Ltd.

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

