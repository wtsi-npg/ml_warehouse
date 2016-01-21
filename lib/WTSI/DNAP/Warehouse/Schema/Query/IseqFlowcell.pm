package WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell;

use Moose::Role;
use MooseX::Role::Parameterized;
use Carp;
use Readonly;

our $VERSION = '0';

Readonly::Scalar our $NON_INDEXED_LIBRARY      => q[library];
Readonly::Scalar our $CONTROL_LANE             => q[library_control];
Readonly::Scalar our $INDEXED_LIBRARY          => q[library_indexed];
Readonly::Scalar our $INDEXED_LIBRARY_SPIKE    => q[library_indexed_spike];

parameter autonomous => (
  isa    => 'Bool',
  default => 0,
);

role {
  my $p = shift;

  requires qw/
      iseq_flowcell
      flowcell_barcode
      id_flowcell_lims
           / ,
      ($p->autonomous ? (qw/ has_id_run /) : ());

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Query::IseqFlowcell

=head1 SYNOPSIS

=head1 DESCRIPTION

A Moose role for retrieving flowcell rows.

=head1 SUBROUTINES/METHODS

=head2 query_resultset

DBIx resultset returned by the query.

=cut

  has 'query_resultset'  => ( isa        => 'DBIx::Class::ResultSet',
                              is         => 'ro',
                              required   => 0,
                              lazy_build => 1,
                              clearer    => 'free_query_resultset',
  );
  method '_build_query_resultset' => sub {
    my $self = shift;

    my $id_run = $p->autonomous && $self->has_id_run && $self->id_run;
    if (!$self->id_flowcell_lims && !$self->flowcell_barcode && !$id_run) {
      croak $p->autonomous ?
        q[Either id_flowcell_lims, flowcell_barcode or id_run should be defined] :
        q[Either id_flowcell_lims or flowcell_barcode should be defined] ;
    }

    my %query;
    if ( $self->id_flowcell_lims) { $query{'me.id_flowcell_lims'} = $self->id_flowcell_lims; }
    elsif ( $id_run ) { $query{'iseq_product_metrics.id_run'} = $id_run; }
    elsif (0 or $self->flowcell_barcode) { $query{'me.flowcell_barcode'} = $self->flowcell_barcode; }

    if ($self->can('position') && $self->position) {
      $query{'me.position'} = $self->position;
    }

    #Note we do not filter on tag_index here as we'll need the phiX spike record even when not asking for it

    my $rs = $self->iseq_flowcell->search( \%query, {
      ($id_run ? ( 'join' => 'iseq_product_metrics') :())
    });

    $self->_check_fc($rs, $id_run);

    return $rs->search({}, {'order_by' => [qw(me.position me.tag_index)]});
  };

  sub _check_fc {
    my ($self, $rs, $id_run) = @_;

    my @columns = qw/id_flowcell_lims flowcell_barcode/ ;
    if ($id_run){
      push @columns, {'id_run' => 'iseq_product_metrics.id_run'};
    }
    my @colnames = map {ref $_ ? keys %{$_} : $_} @columns;
    my @check_rs = $rs->search({}, {'columns'=>\@columns, 'group_by'=>\@colnames, 'order_by'=>\@colnames});
    if (@check_rs > 1) {
      my @info = ();
      push @info, q[Multiple flowcell identifies:];
      push @info, join q[:], @colnames;
      foreach my$row(@check_rs){
        push @info, join q[:], map { q['].$row->get_column($_).q['] || q[unknown] } @colnames;
      }
      croak join qq[\n], @info;
    }
    if ( @check_rs ) {
      for my$c ( @colnames ) {
        my $w =  $check_rs[0]->get_column($c);
        my $wq = defined $w ? "'$w'" : 'undefined';
        carp "Declared $c '".($self->$c)."' differs from that found: $wq" if ($self->$c and defined $w and ($self->$c ne $w));
      }
    };

    return;
  }

};
no Moose::Role;

1;
__END__


=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Carp

=item Readonly

=item Moose::Role

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Marina Gourtovaia

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2014 Genome Research Limited

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

