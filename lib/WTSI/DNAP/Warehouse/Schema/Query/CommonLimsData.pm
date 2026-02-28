package WTSI::DNAP::Warehouse::Schema::Query::CommonLimsData;

use Moose::Role;
use Readonly;

our $VERSION = '0';

requires qw/sample study/;

Readonly my @USER_ROLES => qw/manager follower owner/;

Readonly my %DELEGATION_TO_SAMPLE => {
    'sample_id'                => 'id_sample_lims',
    'sample_uuid'              => 'uuid_sample_lims',
    'sample_name'              => 'name',
    'sample_lims'              => 'id_lims',
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
    'sample_is_control'        => 'control',
    'sample_control_type'      => 'control_type',
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

foreach my $rel (qw(sample study)) {

  my $attr = q[_] . $rel . q[_row];
  my $del = $rel eq 'sample' ? \%DELEGATION_TO_SAMPLE : \%DELEGATION_TO_STUDY;

  # Define two private attributes and set up method delegation. Note that
  # the attributes are weak references to result objects. 
  has $attr => (
    isa        => 'Maybe[WTSI::DNAP::Warehouse::Schema::Result::' . ucfirst $rel . ']',
    is         => 'ro',
    weak_ref   => 1,
    lazy_build => 1,
    handles    => $del,
  );

  # Add a builder method for each of the attributes. The builder returns the
  # study or sample relation.
  __PACKAGE__->meta->add_method(
    '_build_' . $attr, sub {my $r = shift; return $r->$rel;}
  );

  # A wrapper around the delegated methods ensures that if a linked study or
  # sample record is not available, the method returns an undefined value
  # rather than fails with a run-time error. 
  foreach my $method ( keys %{$del} ) {
    around $method => sub {
      my ($orig, $self) = @_;
      return $self->$attr ? $self->$orig() : undef;
    };
  }
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
      my $email_address = $row->email;
      if ($email_address) { # Lots of NULLs in a database
        push @{$su->{$row->role}}, $row->email;
      }
    }
  }
  return $su;
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

1;

__END__

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Query::CommonLimsData

=cut

=head1 SYNOPSIS

=head1 DESCRIPTION

A Moose role, a common interface for quering study and sample properties defined
in the C<sample> and C<study> MLWH tables.

A Result class that consumes this role should have both C<sample> and C<study>
DBIx relation defined.

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 SUBROUTINES/METHODS

=head2 sample_id

=head2 sample_uuid

=head2 sample_name

=head2 sample_lims

=head2 sample_reference_genome

=head2 organism

=head2 sample_accession_number

=head2 sample_common_name

=head2 sample_description

=head2 organism_taxon_id

=head2 sample_public_name

=head2 sample_consent_withdrawn

=head2 sample_supplier_name

=head2 sample_cohort

=head2 sample_donor_id

=head2 sample_is_control

=head2 sample_control_type

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

=head2 email_addresses

=head2 email_addresses_of_owners

=head2 email_addresses_of_followers

=head2 email_addresses_of_managers

=head1 DEPENDENCIES

=over

=item Moose::Role

=item Readonly

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia E<lt>mg8@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2026 Genome Research Ltd.

This file is part of NPG software, ml_warehouse package
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

