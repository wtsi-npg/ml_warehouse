package WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest;

use Moose;
use Carp;
use Readonly;
use MooseX::StrictConstructor;
use List::MoreUtils qw/ none uniq /;

our $VERSION = '0';

Readonly::Hash   my %QUALITY_FILTERS => (
                              'mqc'        => 'qc',
                              'extrelease' => 'external_release',
                                        );

Readonly::Array  my @AGGREGATION_LEVEL => qw/
                                        library
                                        sample
                                            /;

Readonly::Scalar my $GROUP_KEY_NAME => 'group_key';

Readonly::Scalar my $SSCAPE         => q[SQSCP];


=head1 NAME

WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest

=head1 SYNOPSIS

  use DateTime;
  use WTSI::DNAP::Warehouse::Schema;
  use WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest;

  my $s=WTSI::DNAP::Warehouse::Schema->connect();
  my $p=$s->resultset("IseqProductMetric");

  my $d=WTSI::DNAP::Warehouse::Schema::Query::LibraryDigest->new(
    iseq_product_metrics => $p,
    completed_after => DateTime->new(year=>2015,month=>01,day=>30),
    filter => "mqc",
    accept_undefined => 1,
    earliest_run_status => "qc review pending"
  );

  my $digest = $d->create();
  foreach my $library ( keys %{$digest} ) {
    foreach my instrument_type ( keys %{$digest->{$library}} ) {
      foreach my $run_type () {keys %{$digest->{$library}->{$instrument_type}}
        my @entities = @{$digest->{$library}->{$instrument_type}->{}->{'entities'}};

        #######################################################
        # Single entity example
        # {
        #   'flowcell_barcode' => 'C5DW3ANXX',
        #   'status'           => 'qc complete',
        #   'id_lims'          => 'SQSCP',
        #   'new_library_id'   => 'DN384378S:E12',
        #   'rpt_key'          => '15349:5:93',
        #   'sample_name'      => '3425STDY6021702',
        #   'sample'           => '2192336',
        #   'study'            => '3425',
        #   'reference_genome' => 'Mus_musculus (CGP_NCBIm37)'
        # }
        #
        # If reference_gemone is undefine, might contain
        # 'taxon_id' entry instead 
        ######################################################
      }
    }
  }

=head1 DESCRIPTION

Retrieval and aggregation of information about libraries.

=head1 SUBROUTINES/METHODS

=head2 group_by

Type of entity (library, sample) to group the entries by. Defaults to library.

=cut

has 'group_by'  => ( isa        => 'Str',
                     is         => 'ro',
                     required   => 0,
                     default    => sub { return $AGGREGATION_LEVEL[0]; },
                     trigger    => \&_validate_grouping,
);
sub _validate_grouping {
  my ($self, $group) = @_;
  if (none {$_ eq $group } @AGGREGATION_LEVEL) {
    croak "Cannot group by $group, known aggregation levels: " .
      join q[, ], @AGGREGATION_LEVEL;
  }
  return 1;
}

=head2 filter

If set, the libraries should have passed quality control. "seqqc" quality control filter
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
    croak "Cannot filter by $filter, known filters: " . join q[, ], @filters;
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

Boolen flag, false by default, ie control/spiked in libraries are not included.

=cut
has 'include_control' => ( isa           => 'Bool',
                           is            => 'ro',
                           required      => 0,
                           default       => 0,
);

=head2 completed_after

The earliest QC complete date as DateTime object or
the earliest date for required status, an optional attribute.

=cut
has 'completed_after' => ( isa           => 'Maybe[DateTime]',
                           is            => 'ro',
                           required      => 0,
);

=head2 completed_within

QC complete date range as an array ref of DateTime objects or
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
  my $expected = 'IseqProductMetric';
  if ($table !~ /$expected/smx) {
    croak "Got $table, expected result set for $expected";
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

=head2 library_id

An optional legacy_library_id. Only libraries with a legacy_library_id
are supported with this option.
Should be used with the appropriate look back --num_days or --id_runs.
Only one of the run ids is required as expand_libs will find the others

=cut

has 'library_id'   => ( isa        => 'ArrayRef[Int]',
                        is         => 'ro',
                        required   => 0,
                        predicate  => '_has_library_id',
);


=head2 id_study_lims

An option id_study_lims

=cut

has 'id_study_lims'               =>  ( isa        => 'Str',
                                        is         => 'ro',
                                        required   => 0,
                                        predicate  => '_has_id_study_lims',
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

  my $run_status = $self->earliest_run_status;
  if (!$run_status) {
    return [];
  }

  my $schema = $self->iseq_product_metrics->result_source->schema;
  my $temporal_index_row = $schema->resultset('IseqRunStatusDict')->search(
    {'iscurrent' => 1, 'description' => $run_status})->next;
  if (!$temporal_index_row) {
    croak "Invalid run status: '$run_status'";
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

Individual results are presented as a hash reference where the rpt_key (run-position-tag)
key describes the product and other keys define metadata.

Results of one type are bundled together into an array. 

=cut

sub create {
  my $self = shift;

  my $digest = {};
  my $flowcell_keys = $self->_find_libs($digest);

  if (scalar keys %{$digest}) {
    if ( !@{$flowcell_keys} ) {
      croak 'flowcell_keys array is empty';
    }
    if (! $self->_has_id_study_lims) { $self->_expand_libs($digest, $flowcell_keys); }

    foreach my $key (keys %{$digest}) {
      delete $digest->{$key}->{$GROUP_KEY_NAME};
    }

  } else {
    warn "Digest is empty\n";
  }

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
  my ($self, $digest) = @_;
  my @flowcell_keys = ();
  my $where = {};
  my $with_status = 0;
  if ($self->_has_id_study_lims) {
     if (!$self->earliest_run_status) {
         croak 'Should have earliest run status';
     }
     my $study_rs = $self->_get_study_rs({'id_study_lims' => $self->id_study_lims});
    $where->{'iseq_flowcell.id_study_tmp'} = $study_rs->[0]->id_study_tmp;
    $with_status = 1;
 } elsif ($self->_has_id_run || $self->earliest_run_status) {
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
      if (!$self->_accept($prow)) {
        next;
      }
      if (!$self->include_rad && $fc_row->is_r_and_d) {
        next;
      }
      if ( !$self->include_control && $fc_row->entity_type =~ /control|spike/smx ) {
        next;
      }
      if ( $self->_has_library_id() && none {$_ == $fc_row->legacy_library_id} @{$self->library_id()} ) {
        next;
      }
      if ($fc_row->sample_consent_withdrawn){
	next;
      }

       my $entity = $self->_create_entity($fc_row);
      if (!$entity->{'flowcell_key_value'}) {
        croak 'No flowcell key value';
      }
      push @flowcell_keys, $entity->{'flowcell_key_value'};
      $self->_add_entity($digest, $prow, $entity, $with_status);
    }
  }

  return \@flowcell_keys;
}

sub _expand_libs {
  my ($self, $digest, $flowcell_keys) = @_;

  my $count = 0;

  my @search_keys = map {
    $digest->{$_}->{$GROUP_KEY_NAME} ?
      $digest->{$_}->{$GROUP_KEY_NAME} : croak 'Group key is not defined';
                        } keys %{$digest};


  my @keys = uniq map { keys %{$_} } @search_keys;

  if (!@keys) {
    croak 'No keys';
  }
  if (scalar @keys > 1) {
    croak 'Too many keys';
  }
  my $field = $keys[0]; # expect 'legacy_library_id' or 'id_sample_tmp'

  @keys = map { $_->{$field} } @search_keys;

  my $where = {
    'iseq_flowcell.id_iseq_flowcell_tmp' => {'-not_in', $flowcell_keys} ,
    'iseq_flowcell.' . $field            => {'-in',    \@keys},
  };
  my $rs = $self->_get_product_rs($where);
  $count = $rs->count;

  my $with_status = 1;
  while (my $prow = $rs->next) {
    $self->_add_entity($digest,
                       $prow,
                       $self->_create_entity($prow->iseq_flowcell),
                       $with_status);
  }

  return $count;
}

sub _add_entity {
  my ($self, $digest, $prow, $combined_entity, $with_status) = @_;

  my $entity = $combined_entity->{'entity'};

  if ($with_status) {
    my $status = _get_run_status($prow);
    if (scalar @{$self->_valid_run_statuses}) {
      if ( none { $_ eq $status } @{$self->_valid_run_statuses} ) {
        warn "Skipping entry with status $status\n";
        return;
      }
      if (!$self->_accept($prow)){
        warn "Skipping failed entry\n";
        return;
      }
    }
    $entity->{'status'} = $status;
  }

  my ($instrument_model, $flowcell_barcode, $paired_flag, $cycles) = _get_run_data($prow);

  $entity->{'flowcell_barcode'}  = $flowcell_barcode;
  $entity->{'cycles'}            = $cycles;
  $entity->{'rpt_key'}           = $prow->can('rpt_key') ? $prow->rpt_key() : _get_rpt_key($prow);

  my $key = $entity->{$self->group_by};
  if (!$key) {
    croak $self->group_by . ' is not defined for the entity';
  }

  $entity->{'rpt_key'}   = $prow->can('rpt_key') ? $prow->rpt_key : _get_rpt_key($prow);
  if (!exists $digest->{$key}->{$GROUP_KEY_NAME}) {
    $digest->{$key}->{$GROUP_KEY_NAME} = $combined_entity->{'entity_key'};
  }

  push @{$digest->{$key}->{$instrument_model}->{$paired_flag}->{'entities'}}, $entity;

  return;
}


sub _accept {
  my ($self, $row) = @_;

  my $quality_field = $self->filter ? $QUALITY_FILTERS{$self->filter} : q[];

  if ( $quality_field ) {

    ##extrelease is in the iseq_flowcell table
    if ($quality_field ne 'qc') {$row=$row->iseq_flowcell}

    my $value = $row->$quality_field;  #e.g. 0 1 NULL
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
  my $cycles  = $lane_row->cycles;

  return ($instrument_model, $barcode, $paired_flag, $cycles);
}

sub _get_product_rs {
  my ($self, $where) = @_;

  my $join =  { 'join' => [qw/iseq_run_lane_metric iseq_flowcell/] };
  my $rs = $self->iseq_product_metrics->search($where, $join);

  return $rs;
}

sub  _get_study_rs {
    my ($self,$where) = @_;
    my $schema = $self->iseq_product_metrics->result_source->schema;
    my @rs = $schema->resultset('Study')->search($where);
    return(\@rs);
}

sub _create_entity {
  my ($self, $fc_row) = @_;

  my $entity = {
    'new_library_id'          => $fc_row->id_library_lims,
    'sample'                  => $fc_row->sample_id,
    'sample_name'             => $fc_row->sample_name,
    'sample_common_name'      => $fc_row->sample_common_name,
    'sample_accession_number' => $fc_row->sample_accession_number,
    'id_lims'                 => $fc_row->id_lims,
  };
  $entity->{'study'}                  = $fc_row->study_id; # safer, since study might be undefined
  $entity->{'study_accession_number'} = $fc_row->study_accession_number;
  $entity->{'aligned'}                = $fc_row->study_alignments_in_bam;
  $entity->{'study_title'}            = $fc_row->study_title;
  $entity->{'study_name'}             = $fc_row->study_name;
  $entity->{'library_type'}           = $fc_row->default_library_type; #pipeline_id_lims

  my $ref = _get_reference($fc_row);
  if ($ref) {
    $entity->{'reference_genome'} = $ref;
  } else {
    my $taxon_id = $fc_row->organism_taxon_id;
    if ($taxon_id) {
      $entity->{'taxon_id'} = $taxon_id;
    }
  }

  my $tag1_sequence_length = $fc_row->tag_sequence ? (length $fc_row->tag_sequence) : 0;
  my $tag2_sequence_length = $fc_row->tag2_sequence ? (length $fc_row->tag2_sequence) : 0;
  my $expected_cycles      = $tag1_sequence_length + ($fc_row->forward_read_length // 0) + ($fc_row->reverse_read_length // 0) + $tag2_sequence_length;

  $entity->{'expected_cycles'} = $expected_cycles;

  my $library_field = $fc_row->id_lims eq $SSCAPE ? 'legacy_library_id' : 'id_library_lims';
  $entity->{'library'} = $fc_row->$library_field;
  my $key = $self->group_by eq 'library' ? $library_field : 'id_sample_tmp';
  my $key_hash = {$key => $fc_row->$key};

  my $combined_entity = {};
  $combined_entity->{'entity'}             = $entity;
  $combined_entity->{'flowcell_key_value'} = $fc_row->id_iseq_flowcell_tmp;
  $combined_entity->{'entity_key'}         = $key_hash;
  return $combined_entity;
}

sub _get_reference {
  my $fc_row = shift;
  my $ref = $fc_row->sample_reference_genome;
  if ($ref){ $ref =~ s/^\s+//xms }
  $ref ||= $fc_row->study_reference_genome;
  $ref =~ s/^\s+//xms;
  return $ref;
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

