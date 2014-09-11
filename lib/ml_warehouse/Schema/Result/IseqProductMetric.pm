use utf8;
package ml_warehouse::Schema::Result::IseqProductMetric;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

ml_warehouse::Schema::Result::IseqProductMetric

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

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<iseq_product_metrics>

=cut

__PACKAGE__->table("iseq_product_metrics");

=head1 ACCESSORS

=head2 id_iseq_pr_metrics_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

Internal to this database id, value can change

=head2 id_iseq_lane_metrics_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

Lane metrics id, see "iseq_run_lane_metrics.id_iseq_lane_metrics_tmp"

=head2 id_iseq_flowcell_tmp

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

Flowcell id, see "iseq_flowcell.id_iseq_flowcell_tmp"

=head2 id_run

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

NPG run identifier

=head2 position

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

Flowcell lane number

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

=head2 tag_decode_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 tag_decode_count

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_quartile1

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_quartile3

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 insert_size_median

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 gc_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 gc_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 sequence_mismatch_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [4,2]

=head2 sequence_mismatch_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [4,2]

=head2 adapters_percent_forward_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 adapters_percent_reverse_read

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 contaminants_scan_hit1_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 contaminants_scan_hit1_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 contaminants_scan_hit2_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 contaminants_scan_hit2_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 ref_match1_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ref_match1_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 ref_match2_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 ref_match2_percent

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 q20_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q20_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q30_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q40_yield_kb_forward_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 q40_yield_kb_reverse_read

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 bam_num_reads

  data_type: 'bigint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 bam_percent_mapped_target

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_percent_duplicate_target

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_percent_mapped_human

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_percent_duplicate_human

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 human_split_type

  data_type: 'varchar'
  is_nullable: 1
  size: 5

Allowed values: all, y, xa

=head2 bam_percent_mapped_spike

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 bam_percent_duplicate_spike

  data_type: 'float'
  is_nullable: 1
  size: [5,2]

=head2 genotype_sample_name_match

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 genotype_sample_name_relaxed_match

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 genotype_mean_depth

  data_type: 'float'
  is_nullable: 1
  size: [7,2]

=head2 mean_bait_coverage

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [6,2]

=head2 on_bait_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 on_or_near_bait_percent

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [5,2]

=head2 verify_bam_id_average_depth

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 verify_bam_id_score

  data_type: 'float'
  extra: {unsigned => 1}
  is_nullable: 1
  size: [7,6]

=cut

__PACKAGE__->add_columns(
  "id_iseq_pr_metrics_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "id_iseq_lane_metrics_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "id_iseq_flowcell_tmp",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 1,
  },
  "id_run",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "position",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 0 },
  "tag_index",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "tag_sequence",
  { data_type => "varchar", is_nullable => 1, size => 30 },
  "tag_decode_percent",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "tag_decode_count",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "insert_size_quartile1",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "insert_size_quartile3",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "insert_size_median",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "gc_percent_forward_read",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "gc_percent_reverse_read",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "sequence_mismatch_percent_forward_read",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [4, 2],
  },
  "sequence_mismatch_percent_reverse_read",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [4, 2],
  },
  "adapters_percent_forward_read",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "adapters_percent_reverse_read",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "contaminants_scan_hit1_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "contaminants_scan_hit1_score",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  "contaminants_scan_hit2_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "contaminants_scan_hit2_score",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  "ref_match1_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "ref_match1_percent",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "ref_match2_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "ref_match2_percent",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "q20_yield_kb_forward_read",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "q20_yield_kb_reverse_read",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "q30_yield_kb_forward_read",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "q30_yield_kb_reverse_read",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "q40_yield_kb_forward_read",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "q40_yield_kb_reverse_read",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "bam_num_reads",
  { data_type => "bigint", extra => { unsigned => 1 }, is_nullable => 1 },
  "bam_percent_mapped_target",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "bam_percent_duplicate_target",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "bam_percent_mapped_human",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "bam_percent_duplicate_human",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "human_split_type",
  { data_type => "varchar", is_nullable => 1, size => 5 },
  "bam_percent_mapped_spike",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "bam_percent_duplicate_spike",
  { data_type => "float", is_nullable => 1, size => [5, 2] },
  "genotype_sample_name_match",
  { data_type => "varchar", is_nullable => 1, size => 8 },
  "genotype_sample_name_relaxed_match",
  { data_type => "varchar", is_nullable => 1, size => 8 },
  "genotype_mean_depth",
  { data_type => "float", is_nullable => 1, size => [7, 2] },
  "mean_bait_coverage",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [6, 2],
  },
  "on_bait_percent",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "on_or_near_bait_percent",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [5, 2],
  },
  "verify_bam_id_average_depth",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 1 },
  "verify_bam_id_score",
  {
    data_type => "float",
    extra => { unsigned => 1 },
    is_nullable => 1,
    size => [7, 6],
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id_iseq_pr_metrics_tmp>

=back

=cut

__PACKAGE__->set_primary_key("id_iseq_pr_metrics_tmp");

=head1 RELATIONS

=head2 id_iseq_flowcell_tmp

Type: belongs_to

Related object: L<ml_warehouse::Schema::Result::IseqFlowcell>

=cut

__PACKAGE__->belongs_to(
  "id_iseq_flowcell_tmp",
  "ml_warehouse::Schema::Result::IseqFlowcell",
  { id_iseq_flowcell_tmp => "id_iseq_flowcell_tmp" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "NO ACTION",
  },
);

=head2 id_iseq_lane_metrics_tmp

Type: belongs_to

Related object: L<ml_warehouse::Schema::Result::IseqRunLaneMetric>

=cut

__PACKAGE__->belongs_to(
  "id_iseq_lane_metrics_tmp",
  "ml_warehouse::Schema::Result::IseqRunLaneMetric",
  { id_iseq_lane_metrics_tmp => "id_iseq_lane_metrics_tmp" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2014-09-10 16:38:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aTIzKFY3FK5LxtamTOJG3w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
