
package WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

WTSI::DNAP::Warehouse::Schema::Result::PacBioProductMetric

=head1 DESCRIPTION

A linking table for the pac_bio_run and pac_bio_run_well_metrics tables with a potential for adding per-product QC data

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

=head1 TABLE: C<pac_bio_product_metrics>

=cut

__PACKAGE__->table('pac_bio_product_metrics');

=head1 ACCESSORS

=head2 id_pac_bio_pr_metrics_tmp

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 id_pac_bio_rw_metrics_tmp

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

PacBio run well metrics id, see 'pac_bio_run_well_metrics.id_pac_bio_rw_metrics_tmp'

=head2 id_pac_bio_tmp

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

PacBio run id, see 'pac_bio_run.id_pac_bio_tmp'

=head2 id_pac_bio_product

  data_type: 'char'
  is_nullable: 0
  size: 64

Product id

=head2 qc

  data_type: 'tinyint'
  is_nullable: 1

The final QC outcome of the product as 0(failed), 1(passed) or NULL

=head2 last_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

Date this record was created or changed

=cut

__PACKAGE__->add_columns(
  'id_pac_bio_pr_metrics_tmp',
  { data_type => 'integer', is_auto_increment => 1, is_nullable => 0 },
  'id_pac_bio_rw_metrics_tmp',
  { data_type => 'integer', is_foreign_key => 1, is_nullable => 0 },
  'id_pac_bio_tmp',
  { data_type => 'integer', is_foreign_key => 1, is_nullable => 1 },
  'id_pac_bio_product',
  { data_type => 'char', is_nullable => 0, size => 64 },
  'qc',
  { data_type => 'tinyint', is_nullable => 1 },
  'last_changed',
  {
    data_type => 'datetime',
    datetime_undef_if_invalid => 1,
    default_value => 'CURRENT_TIMESTAMP',
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_pac_bio_pr_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key('id_pac_bio_pr_metrics_tmp');

=head1 UNIQUE CONSTRAINTS

=head2 C<pac_bio_metrics_product>

=over 4

=item * L</id_pac_bio_tmp>

=item * L</id_pac_bio_rw_metrics_tmp>

=back

=cut

__PACKAGE__->add_unique_constraint(
  'pac_bio_metrics_product',
  ['id_pac_bio_tmp', 'id_pac_bio_rw_metrics_tmp'],
);

=head2 C<pac_bio_pr_metrics_id_product>

=over 4

=item * L</id_pac_bio_product>

=back

=cut

__PACKAGE__->add_unique_constraint('pac_bio_pr_metrics_id_product', ['id_pac_bio_product']);

=head1 RELATIONS

=head2 pac_bio

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::PacBioRun>

=cut

__PACKAGE__->belongs_to(
  'pac_bio',
  'WTSI::DNAP::Warehouse::Schema::Result::PacBioRun',
  { id_pac_bio_tmp => 'id_pac_bio_tmp' },
  {
    is_deferrable => 1,
    join_type     => 'LEFT',
    on_delete     => 'SET NULL',
    on_update     => 'RESTRICT',
  },
);

=head2 pac_bio_rw_metrics

Type: belongs_to

Related object: L<WTSI::DNAP::Warehouse::Schema::Result::PacBioRunWellMetric>

=cut

__PACKAGE__->belongs_to(
  'pac_bio_rw_metrics',
  'WTSI::DNAP::Warehouse::Schema::Result::PacBioRunWellMetric',
  { id_pac_bio_rw_metrics_tmp => 'id_pac_bio_rw_metrics_tmp' },
  { is_deferrable => 1, on_delete => 'CASCADE', on_update => 'RESTRICT' },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-10-23 16:47:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hTT2fzNhcm/86YuT61o2Qw

use Carp;

our $VERSION = '0';


=head2 get_tags

Returns an array containing tag_sequence and tag2_sequence values for the
linked row in pac_bio_run. If no linked row is available, an error is thrown.

=cut

sub get_tags {
  my $self = shift;
  if ($self->pac_bio){
    return $self->pac_bio->get_tags;
  }else{
    croak('No linked row in pac_bio_run table');
  }
}

__PACKAGE__->meta->make_immutable;
1;

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

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2021, 2023 Genome Research Ltd.

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
