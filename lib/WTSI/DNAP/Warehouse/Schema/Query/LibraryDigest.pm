package WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest;

use Moose;
use Carp;
use Readonly;
use MooseX::StrictConstructor;
use List::MoreUtils qw/ none /;

our $VERSION = '0';

Readonly::Hash  my %QUALITY_FILTERS => (
                              'mqc'        => 'manual_qc',
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

=head2 accept_undefined

If the filter attribute is set, undefined is accepted as a valid
value for the filter. Defaults to false, ie only true values are
accepted.

=cut

has 'accept_undefined'  => ( isa        => 'Bool',
                             is         => 'ro',
                             required   => 0,
                             default    => 0,
);

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

The earliest qc complete date as DateTime object or
the earliest date for required status, an optional attribute.

=cut
has 'completed_after' => ( isa           => 'Maybe[DateTime]',
                           is            => 'ro',
                           required      => 0,
);

=head2 completed_within

Qc complete date range as an array ref of DateTime objects or
a valid time interval for required status, an optional attribute.

=cut
has 'completed_within' => ( isa           => 'ArrayRef[DateTime]',
                            is            => 'ro',
                            required      => 0,
                            default       => sub {return [];},
);

=head2 iseq_product_metrics

DBIx result set for the iseq_product_metrics table.

=cut

has 'iseq_product_metrics' =>  ( isa        => 'DBIx::Class::ResultSet',
                                 is         => 'ro',
                                 required   => 1,
                                 trigger    => \&_validate_rs,
);
sub _validate_rs {
  my ($self, $rs) = @_;
  my $table = $rs->result_class;
  if ($table !~ /IseqProductMetric/smx) {
    croak "Got $table, expected result set for iseq_product_metrics";
  }
  return 1;
}

=head2 earliest_run_status

Earliest run status.

=cut

has 'earliest_run_status'  =>  ( isa        => 'Str',
                                 is         => 'ro',
                                 required   => 0,
);

=head2 id_run

An optional array of run ids.

=cut

has 'id_run'               =>  ( isa        => 'ArrayRef[Int]',
                                 is         => 'ro',
                                 required   => 1,
                                 predicate  => '_has_id_run',
                                 lazy_build => 1,
);
sub _build_id_run {
  my $self = shift;

  if (!$self->earliest_run_status) {
    croak 'Should have earliest run status';
  }

  my $time_expression = $self->_time_interval_query();
  if (!$time_expression) {
    croak 'Time limits should be defined';
  }

  my $schema = $self->iseq_product_metrics->result_source->schema;
  my @statuses = $schema->resultset('IseqRunStatus')->search(
    {
      'me.iscurrent' => 1,
      'date'         => $time_expression,
      'run_status_dict.description' =>
        {'-in' => $self->_valid_run_statuses},
    },
    { 'join' => 'run_status_dict',}
  )->all();

  my @runs = map { $_->id_run } @statuses;

  return \@runs;
}

has '_valid_run_statuses' =>  ( isa        => 'ArrayRef[Str]',
                                is         => 'ro',
                                required   => 1,
                                lazy_build => 1,
);
sub _build__valid_run_statuses {
  my $self = shift;

  if (!$self->earliest_run_status) {
    return [];
  }

  my $schema = $self->iseq_product_metrics->result_source->schema;
  my $temporal_index_row = $schema->resultset('IseqRunStatusDict')->search(
    {'iscurrent' => 1, 'description' => $self->earliest_run_status})->next;
  if (!$temporal_index_row) {
    croak 'Invalid status: ' . $self->earliest_run_status;
  }
  my $temporal_index = $temporal_index_row->temporal_index;

  my @statuses = $schema->resultset('IseqRunStatusDict')->search({
      'iscurrent' => 1,
      'temporal_index' => {q[>=], $temporal_index},
      'description'    => {'-not_like' => '%hold'},
  })->all();

  @statuses = sort map { $_->description } @statuses;

  return \@statuses;
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

  my $digest = {};
  my $flowcell_keys = [];
  $self->_find_libs($digest, $flowcell_keys);
  $self->_expand_libs($digest, $flowcell_keys);

  return $digest;
}

sub _time_interval_query {
  my $self = shift;

  my $dtf = $self->iseq_product_metrics->result_source->storage->datetime_parser;
  my $expression;
  if ($self->completed_after) {
    my $operator = $self->completed_after ? q[>=] : q[-between];
    $expression = {q[>=], $dtf->format_datetime($self->completed_after)};
    # also include that the date is defined?
  } elsif (@{$self->completed_within}) {
    my @between = map { $dtf->format_datetime($_) } @{$self->completed_within};
    $expression = {q[-between], \@between};
  }
  return $expression;
}

sub _find_libs {
  my ($self, $digest, $flowcell_keys) = @_;

  my $where = {};
  my $with_status = 0;
  if ($self->_has_id_run || $self->earliest_run_status) {
    $where->{'me.id_run'} = {'-in', $self->id_run};
    $with_status = 1;
  } else {
    my $time_expression = $self->_time_interval_query();
    if ($time_expression) {
      $where->{'iseq_run_lane_metric.run_complete'} = $time_expression;
    }
  }
  my $rs = $self->_get_product_rs($where);

  while (my $prow = $rs->next()) {

    my $fc_row = $prow->iseq_flowcell;
    if ($fc_row) {

      if (!$self->_accept($fc_row)) {
        next;
      }
      if (!$self->include_rad && $fc_row->is_r_and_d) {
        next;
      }
      if ( !$self->include_control && $fc_row->entity_type =~ /control|spike/smx ) {
        next;
      }

      my $entity = _create_entity($fc_row, $flowcell_keys);
      $self->_add_entity($digest, $prow, $entity, $with_status);
    }
  }

  return;
}

sub _expand_libs {
  my ($self, $digest, $flowcell_keys) = @_;

  my $count = 0;
  my @libraries = keys %{$digest};
  if (@libraries) {
    my $with_status = 1;
    my $where = {
      'iseq_flowcell.id_iseq_flowcell_tmp' => {'-not_in', $flowcell_keys} ,
      'iseq_flowcell.id_library_lims'      => {'-in',    \@libraries}
    };
    my $rs = $self->_get_product_rs($where);
    $count = $rs->count;

    while (my $prow = $rs->next) {
      my $entity = _create_entity($prow->iseq_flowcell);
      $self->_add_entity($digest, $prow, $entity, $with_status);
    }
  }

  return $count;
}

sub _add_entity {
  my ($self, $digest, $prow, $entity, $with_status) = @_;

  if ($with_status) {
    my $status = _get_run_status($prow);
    if (scalar @{$self->_valid_run_statuses}) {
      if ( none { $_ eq $status } @{$self->_valid_run_statuses} ) {
        warn "Skipping entry with status $status\n";
        return;
      }
      if (!$self->_accept($prow->iseq_flowcell)) {
        warn "Skipping failed entry\n";
        return;
      }
    }
    $entity->{'status'} = $status;
  }

  my ($instrument_model, $flowcell_barcode, $paired_flag) = _get_run_data($prow);

  $entity->{'flowcell_barcode'}  = $flowcell_barcode;
  $entity->{'rpt_key'} =
    $prow->can('rpt_key') ? $prow->rpt_key() : _get_rpt_key($prow);
  my $library = $entity->{'library'};
  delete $entity->{'library'};
  $entity->{'rpt_key'} = $prow->can('rpt_key') ? $prow->rpt_key : _get_rpt_key($prow);

  push @{$digest->{$library}->{$instrument_model}->{$paired_flag}->{'entities'}},
      $entity;

  return;
}

sub _accept {
  my ($self, $fc_row) = @_;
  my $quality_field = $self->filter ? $QUALITY_FILTERS{$self->filter} : q[];
  if ( $quality_field ) {
    my $value = $fc_row->$quality_field;
    return $value || ($self->accept_undefined && !defined $value);
  }
  return 1;
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
  my ($fc_row, $fc_keys) = @_;

  my $entity = {
    'sample'      => $fc_row->sample_id,
    'sample_name' => $fc_row->sample_name,
    'study'       => $fc_row->study_id,
    'library'     => $fc_row->id_library_lims,
    'id_lims'     => $fc_row->id_lims,
  };
  my $ref = $fc_row->sample_reference_genome || $fc_row->study_reference_genome;
  if ($ref) {
    $entity->{'reference_genome'} = $ref;
  }

  push @{$fc_keys}, $fc_row->id_iseq_flowcell_tmp;

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

=item MooseX::StrictConstructor

=item List::MoreUtils

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

