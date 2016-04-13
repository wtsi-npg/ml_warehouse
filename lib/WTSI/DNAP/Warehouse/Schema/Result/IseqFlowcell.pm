
package WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::IseqFlowcell

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

=head1 TABLE: C<iseq_flowcell>

=cut

__PACKAGE__->table('iseq_flowcell');

=head1 ACCESSORS

=head2 id_iseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

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
  is_nullable: 1

Study id, see 'study.id_study_tmp'

=head2 cost_code

  data_type: 'varchar'
  is_nullable: 1
  size: 20

Valid WTSI cost code

=head2 is_r_and_d

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

A boolean flag derived from cost code, flags RandD

=head2 id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 10

LIM system identifier, e.g. CLARITY-GCLP, SEQSCAPE

=head2 priority

  data_type: 'smallint'
  default_value: 1
  extra: {unsigned => 1}
  is_nullable: 1

Priority

=head2 manual_qc

  data_type: 'tinyint'
  is_nullable: 1

Manual QC decision, NULL for unknown

=head2 external_release

  data_type: 'tinyint'
  is_nullable: 1

Defaults to manual qc value; can be changed by the user later

=head2 flowcell_barcode

  data_type: 'varchar'
  is_nullable: 1
  size: 15

Manufacturer flowcell barcode or other identifier

=head2 id_flowcell_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

LIMs-specific flowcell id, batch_id for Sequencescape

=head2 position

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

Flowcell lane number

=head2 entity_type

  data_type: 'varchar'
  is_nullable: 0
  size: 30

Lane type: library, pool, library_control, library_indexed, library_indexed_spike

=head2 entity_id_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Most specific LIMs identifier associated with this lane or plex or spike

=head2 tag_index

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Tag index, NULL if lane is not a pool

=head2 tag_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence

=head2 tag_set_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 20

LIMs-specific identifier of the tag set

=head2 tag_set_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

WTSI-wide tag set name

=head2 tag_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 30

The position of tag within the tag group

=head2 tag2_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Tag sequence for tag 2

=head2 tag2_set_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 20

LIMs-specific identifier of the tag set for tag 2

=head2 tag2_set_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

WTSI-wide tag set name for tag 2

=head2 tag2_identifier

  data_type: 'varchar'
  is_nullable: 1
  size: 30

The position of tag2 within the tag group

=head2 is_spiked

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

Boolean flag indicating presence of a spike

=head2 pipeline_id_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 60

LIMs-specific pipeline identifier that unambiguously defines library type

=head2 bait_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

WTSI-wide name that uniquely identifies a bait set

=head2 requested_insert_size_from

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Requested insert size min value

=head2 requested_insert_size_to

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

Requested insert size max value

=head2 forward_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Requested forward read length, bp

=head2 reverse_read_length

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

Requested reverse read length, bp

=head2 id_pool_lims

  data_type: 'varchar'
  is_nullable: 0
  size: 20

Most specific LIMs identifier associated with the pool

=head2 legacy_library_id

  data_type: 'integer'
  is_nullable: 1

Legacy library_id for backwards compatibility.

=head2 id_library_lims

  data_type: 'varchar'
  is_nullable: 1
  size: 255

Earliest LIMs identifier associated with library creation

=head2 team

  data_type: 'varchar'
  is_nullable: 1
  size: 255

The team responsible for creating the flowcell

=head2 purpose

  data_type: 'varchar'
  is_nullable: 1
  size: 30

Describes the reason the sequencing was conducted. Eg. Standard, QC, Control

=cut

__PACKAGE__->add_columns(
  'id_iseq_flowcell_tmp',
  {
    data_type => 'integer',
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
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
    is_nullable => 1,
  },
  'cost_code',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'is_r_and_d',
  { data_type => 'tinyint', default_value => 0, is_nullable => 1 },
  'id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 10 },
  'priority',
  {
    data_type => 'smallint',
    default_value => 1,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  'manual_qc',
  { data_type => 'tinyint', is_nullable => 1 },
  'external_release',
  { data_type => 'tinyint', is_nullable => 1 },
  'flowcell_barcode',
  { data_type => 'varchar', is_nullable => 1, size => 15 },
  'id_flowcell_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'position',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 0 },
  'entity_type',
  { data_type => 'varchar', is_nullable => 0, size => 30 },
  'entity_id_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'tag_index',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'tag_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'tag_set_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'tag_set_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'tag_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'tag2_sequence',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'tag2_set_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 20 },
  'tag2_set_name',
  { data_type => 'varchar', is_nullable => 1, size => 100 },
  'tag2_identifier',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
  'is_spiked',
  { data_type => 'tinyint', default_value => 0, is_nullable => 0 },
  'pipeline_id_lims',
  { data_type => 'varchar', is_nullable => 1, size => 60 },
  'bait_name',
  { data_type => 'varchar', is_nullable => 1, size => 50 },
  'requested_insert_size_from',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'requested_insert_size_to',
  { data_type => 'integer', extra => { unsigned => 1 }, is_nullable => 1 },
  'forward_read_length',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'reverse_read_length',
  { data_type => 'smallint', extra => { unsigned => 1 }, is_nullable => 1 },
  'id_pool_lims',
  { data_type => 'varchar', is_nullable => 0, size => 20 },
  'legacy_library_id',
  { data_type => 'integer', is_nullable => 1 },
  'id_library_lims',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'team',
  { data_type => 'varchar', is_nullable => 1, size => 255 },
  'purpose',
  { data_type => 'varchar', is_nullable => 1, size => 30 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_iseq_flowcell_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_iseq_flowcell_tmp');

=head1 RELATIONS

=head2 iseq_product_metrics

Type: has_many

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric>

=cut

__PACKAGE__->has_many(
  'iseq_product_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::IseqProductMetric',
  { 'foreign.id_iseq_flowcell_tmp' => 'self.id_iseq_flowcell_tmp' },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sample

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Sample>

=cut

__PACKAGE__->belongs_to(
  'sample',
  'WTSI::DNAP::Warehouse::Schema::Result::Sample',
  { id_sample_tmp => 'id_sample_tmp' },
  { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

=head2 study

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::Study>

=cut

__PACKAGE__->belongs_to(
  'study',
  'WTSI::DNAP::Warehouse::Schema::Result::Study',
  { id_study_tmp => 'id_study_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'NO ACTION',
    on_update     => 'NO ACTION',
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-12-08 10:12:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:elVRHSNY/zTS50jaYHpAbQ

use MooseX::Aliases;
use Readonly;

our $VERSION = '0';

with 'WTSI::DNAP::Warehouse::Schema::Query::LimsFlags';

Readonly my @USER_ROLES => qw/manager follower owner/;

Readonly my %DELEGATION_TO_SAMPLE => {
    'sample_id'                => 'id_sample_lims',
    'sample_name'              => 'name',
    'sample_reference_genome'  => 'reference_genome',
    'organism'                 => 'organism',
    'sample_accession_number'  => 'accession_number',
    'sample_common_name'       => 'common_name',
    'sample_description'       => 'description',
    'organism_taxon_id'        => 'taxon_id',
    'sample_public_name'       => 'public_name',
    'sample_consent_withdrawn' => 'consent_withdrawn',
    'sample_supplier_name'     => 'supplier_name',
    'sample_cohort'            => 'cohort',
    'sample_donor_id'          => 'donor_id',
};

Readonly my %DELEGATION_TO_STUDY => {
    'study_id'                            => 'id_study_lims',
    'study_name'                          => 'name',
    'study_reference_genome'              => 'reference_genome',
    'study_accession_number'              => 'accession_number',
    'study_description'                   => 'description',
    'study_contains_nonconsented_human'   => 'contaminated_human_dna',
    'study_title'                         => 'study_title',
    'study_contains_nonconsented_xahuman' => 'remove_x_and_autosomes',
    'study_alignments_in_bam'             => 'aligned',
    'study_separate_y_chromosome_data'    => 'separate_y_chromosome_data',
};

alias project_cost_code       => 'cost_code';
alias default_library_type    => 'pipeline_id_lims';
alias lane_priority           => 'priority';
alias lane_id                 => 'entity_id_lims';
alias default_tag_sequence    => 'tag_sequence';
alias default_tagtwo_sequence => 'tag2_sequence';
alias library_name            => 'library_id';

sub qc_state {
  my $self = shift;
  return $self->iseq_product_metrics()->get_column(q[qc])->single();
}

foreach my $rel (qw(sample study)) {

  my $attr = q[_] . $rel . q[_row];
  my $del  = $rel eq 'sample' ? \%DELEGATION_TO_SAMPLE : \%DELEGATION_TO_STUDY;

  has $attr => ( isa        => 'Maybe[WTSI::DNAP::Warehouse::Schema::Result::' . ucfirst $rel . ']',
                 is         => 'ro',
                 weak_ref   => 1,
                 lazy_build => 1,
                 handles    => $del,
  );

  __PACKAGE__->meta->add_method('_build_' . $attr, sub {my $r = shift; return $r->$rel;} );

  foreach my $method ( keys %{$del} ) {
    around $method => sub {
      my ($orig, $self) = @_;
      return $self->$attr ? $self->$orig() : undef;
    };
  }
}

has 'is_control' => ( isa        => 'Bool',
                      is         => 'ro',
                      lazy_build => 1,
);
sub _build_is_control {
  my $self = shift;
  return ( $self->entity_type && $self->entity_type =~ /\Alibrary_control|library_indexed_spike\Z/xms ) ? 1 : 0;
}

has 'required_insert_size_range' => (
                      isa        => 'Maybe[HashRef]',
                      is         => 'ro',
                      lazy_build => 1,
);
sub _build_required_insert_size_range {
  my $self = shift;
  my $min = $self->requested_insert_size_from;
  my $max = $self->requested_insert_size_to;
  my $range;
  if ($min || $max) {
    if (!defined $min) {
      $min = $max;
    }
    if (!defined $max) {
      $max = $min;
    }
    $range = { 'from' => $min, 'to' => $max };
  }
  return $range;
}

has '_study_users' => ( isa        => 'HashRef',
                        is         => 'ro',
                        lazy_build => 1,
);
sub _build__study_users {
  my $self = shift;
  my $su = {};
  my $study = $self->study();
  if ($study) {
    my $rs =  $study->study_users();
    while (my $row = $rs->next) {
      push @{$su->{$row->role}}, $row->email;
    }
  }
  return $su;
}

sub library_id {
  my $self = shift;
  return $self->legacy_library_id || $self->id_library_lims;
}

sub email_addresses {
  my $self = shift;
  my @emails = ();
  foreach my $user_type (@USER_ROLES) {
    if (exists $self->_study_users->{$user_type}) {
      push @emails, map { $_ => 1 } @{$self->_study_users->{$user_type}};
    }
  }
  my %hashed = @emails;
  @emails = sort keys %hashed;
  return \@emails;
}

foreach my $user_type (@USER_ROLES) {
  my $method = 'email_addresses_of_' . $user_type . 's';
  __PACKAGE__->meta->add_method($method, sub {
    my $self = shift;
    my @emails = ();
    if (exists $self->_study_users->{$user_type}) {
      @emails = sort values @{$self->_study_users->{$user_type}};
    }
    return \@emails;
  });
}

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 SYNOPSIS

=head1 DESCRIPTION

Result class definition in DBIx binding for the multi-lims warehouse database.

Defines some helper methods (readers) to access sample and study attributes.
The values returned by these helper methods are likely to be cached, ie will not
change if the underlying values in the database change

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head2 project_cost_code

=head2 default_library_type

=head2 library_id

=head2 qc_state

=head2 lane_priority

=head2 default_tag_sequence

=head2 library_name

=head2 is_control

=head2 required_insert_size_range

=head2 email_addresses

=head2 email_addresses_of_owners

=head2 email_addresses_of_followers

=head2 email_addresses_of_managers

=head2 sample_id

=head2 sample_name

=head2 sample_reference_genome

=head2 organism

=head2 sample_accession_number

=head2 sample_common_name

=head2 sample_description

=head2 organism_taxon_id

=head2 sample_public_name

=head2 sample_consent_withdrawn

=head2 study_id

=head2 study_name

=head2 study_reference_genome

=head2 study_accession_number

=head2 study_description

=head2 study_contains_nonconsented_human

=head2 study_title

=head2 study_contains_nonconsented_xahuman

=head2 study_alignments_in_bam

=head2 study_separate_y_chromosome_data

=head1 DEPENDENCIES

=over

=item strict

=item warnings

=item Moose

=item MooseX::NonMoose

=item MooseX::MarkAsMethods

=item MooseX::Aliases

=item DBIx::Class::Core

=item DBIx::Class::InflateColumn::DateTime

=item Readonly

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

