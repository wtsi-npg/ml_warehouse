alter table iseq_run_lane_metrics \
  drop foreign key `iseq_rl_metrics_flc_fk` ,
  drop column `id_iseq_flowcell_tmp`;

alter table iseq_run_lane_metrics \
  drop column adapters_percent_forward_read, \
  drop column adapters_percent_reverse_read, \
  drop column insert_size_quartile1, \
  drop column insert_size_quartile3, \
  drop column insert_size_median, \
  drop column ref_match1_name, \
  drop column ref_match1_percent, \
  drop column ref_match2_name, \
  drop column ref_match2_percent, \
  drop column gc_percent_forward_read, \
  drop column gc_percent_reverse_read, \
  drop column sequence_mismatch_percent_forward_read, \
  drop column sequence_mismatch_percent_reverse_read;

alter table iseq_product_metrics \
  add column insert_size_num_modes \
  smallint(4) unsigned DEFAULT NULL after insert_size_median;
alter table iseq_product_metrics \
  add column insert_size_normal_fit_confidence \
  float(3,2) unsigned DEFAULT NULL after insert_size_num_modes;

alter table iseq_product_metrics \
  add column verify_bam_id_snp_count int(10) unsigned DEFAULT NULL \
  after verify_bam_id_score;
