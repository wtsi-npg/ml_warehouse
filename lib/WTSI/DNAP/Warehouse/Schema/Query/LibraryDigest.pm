package WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest;

use Moose::Role;
use Carp;
use Readonly;

our $VERSION = '0';

Readonly::Hash  my %QUALITY_FILTERS => (
                              'seqqc'      => 'manual_qc',
                              'extrelease' => 'external_release',
                                       );

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest

=head1 SYNOPSIS

=head1 DESCRIPTION

Retrieval and aggregation of information about libraries.

=head1 SUBROUTINES/METHODS

=head2 filter

If set, the libraries should have pass quality control. "seqqc" quality control filter
is used by default. "extrelease" filter can also be used.

=cut

has 'filter'  => ( isa        => 'Maybe[Str]',
                   is         => 'ro',
                   required   => 0,
                   trigger    => \&_validate_filter,
);
sub _validate_filter {
  my ($self, $filter) = @_;
  my @filters = sort keys %QUALITY_FILTERS;
  if ( none { $_ eq $filter } @filters ) {
    croak "Cannot filter by $filter, known filteres: " . join q[,], @filters;
  }
  return 1;
}

=head2 include_rad

Boolen flag, false by default, ie R&D libraries are not included.

=cut
has 'include_rad' => ( isa           => 'Bool',
                       is            => 'ro',
                       required      => 0,
                       default       => 0,
);

=head2 include_control

Boolen flag, false by default, ie control/spiled in libraries are not included.

=cut
has 'include_control' => ( isa           => 'Bool',
                           is            => 'ro',
                           required      => 0,
                           default       => 0,
);

=head2 completed_after

The earliest qc complete date as DateTime object - an optional attribute.

=cut
has 'completed_after' => ( isa           => 'Maybe[DateTime]',
                           is            => 'ro',
                           required      => 0,
);

=head2 iseq_product_metrics

DBIx result set for the iseq_product_metrics table.

=cut

has 'iseq_product_metrics' =>  ( isa        => 'DBIx::Class::ResultSet',
                                 is         => 'ro',
                                 required   => 1,
                                 trigger    => &_validate_rs,
);
sub _validate_rs {
  my ($self, $rs) = @_;
  my $table = $rs->result_class;
  if ($table !~ /IseqProductMetric/smx) {
    croak "Got $table, expected result set for iseq_product_metrics";
  }
  return 1;
}

=head2 create

Creates a digest in a form of a hash reference where the results
are categorised by the library id, sequencing instrument model and paired|single flag.

Individual results are presented as a hash refenence where the rpt_key (run-position-tag)
key describes the product and other keys define metadata.

Results of one type are bundled together into an array. 

=cut

sub create {
  my $self = shift;

  my $quality_field = $QUALITY_FILTERS{$self->filter};

  my $where = {};
  if ($self->completed_after) {
    my $dtf = $self->iseq_product_metrics->result_source->storage->datetime_parser;
    $where->{'iseq_run_lane_metric.run_complete'} = {q[>=], $dtf->format_datetime($self->completed_after)};
    # also include that the date is defined?
  }
  my $rs = $self->_get_product_rs($where);

  my $digest = {};

  while (my $prow = $rs->next()) {

    my $fc_row = $prow->iseq_flowcell;
    if ($fc_row) {

      if ($self->filter) {
        my $column = $self->filter;
        if (!$fc_row->$column) { # if no qc result or failed
          next;
        }
      }

      if (!$self->include_rad && $fc_row->is_r_and_d) {
        next;
      }
      if ( !$self->include_control && $fc_row->entity_type =~ /control|spike/smx ) {
        next;
      }

      my $entity = _create_entity($fc_row);

      my $passed = 1;
      foreach my $key ( qw/ library sample study / ) {
        if ( $self->can($key) && $self->$key && $self->$key ne $entity->{$key}) {
          $passed = 0;
          last;
	}
      }

      if ($passed) {
        _add_entity($digest, $prow, $entity);
      }
    }
  }

  $self->_expand_libs($digest);

  return $digest;
}

sub _expand_libs {
  my ($self, $digest) = shift;

  my @libraries = keys %{$digest};
  if (@libraries) {
    my $with_status = 1;
    my $where = {'iseq_flowcell.entity_id_lims' => {'--in', \@libraries}};
    my $rs = $self->_get_product_rs($where);
    while (my $prow = $rs->next) {
      my $entity = _create_entity($prow->iseq_lowcell);
      _add_entity($digest, $prow, $entity, $with_status);
    }
  }

  return;
}

sub _add_entity {
  my ($digest, $prow, $entity, $with_status) = @_;

  my ($instrument_model, $flowcell_barcode, $paired_flag) = _get_run_data($prow);

  $entity->{'flowcell_barcode'}  = $flowcell_barcode;
  $entity->{'rpt_key'} =
    $prow->can('rpt_key') ? $prow->rpt_key() : _get_rpt_key($prow);
  my $library = $entity->{'library'};
  delete $entity->{'library'};
  _entity_add_rpt_key($prow, $entity);
  if ($with_status) {
    $entity->{'status'} = _get_run_status($prow);
  }

  push @{$digest->{$library}->{$instrument_model}->{$paired_flag}->{'entities'}},
      $entity;

  return;
}

sub _get_run_data {
  my $product_row = shift;

  my $lane_row = $product_row->iseq_run_lane_metric;
  my $paired_flag     = $lane_row->paired_read ? 'paired' : 'single';
  my $instrument_model = $lane_row->instrument_model;
  my $barcode = $lane_row->flowcell_barcode;

  return ($instrument_model, $barcode, $paired_flag);
}

sub _get_product_rs {
  my ($self, $where) = @_;

  my $join =  { 'join' => [qw/iseq_run_lane_metric iseq_flowcell/] };
  my $rs = $self->iseq_product_metrics->search($where, $join);

  return $rs;
}

sub _create_entity {
  my $fc_row = shift;

  my $entity = {
    'sample'  => $fc_row->sample->id_sample_lims,
    'study'   => $fc_row->study->id_study_lims,
    'library' => $fc_row->entity_id_lims,
    'id_lims' => $fc_row->id_lims,
    'legacy_library_id' => $fc_row->legacy_library_id,
  };

  return $entity;
}


sub _get_run_status {
  my ($product_row) = @_;

  my $run_status;
  my $status_row = $product_row->search_related('iseq_run_status', {iscurrent => 1,})->next;
  if ($status_row) {
    $run_status = $status_row->run_status_dict->description;
  }

  return $run_status;
}

sub _get_rpt_key {
  my $obj = shift;

  my $delim = q[:];
  my $key = join $delim, $obj->id_run, $obj->position;
  if (defined $obj->tag_index) {
    $key = join $delim, $key, $obj->tag_index;
  }

  return $key;
}

no Moose;

1;
__END__


=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Carp

=item Readonly

=item Moose

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2015 Genome Research Limited

This program is free software: you can redistribute it and/or modify
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

