alter table pac_bio_run_well_metrics \
  add column cell_lot_number \
  varchar(32) DEFAULT NULL COMMENT 'SMRT Cell Lot Number' after movie_name,
  add column control_num_reads \
  int unsigned DEFAULT NULL COMMENT 'The number of control reads' after primary_analysis_sw_version,
  add column control_concordance_mean \
  float(8,6) unsigned DEFAULT NULL COMMENT 'The average concordance between the control raw reads and the control reference sequence' after control_num_reads,
  add column control_read_length_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean polymerase read length of the control reads' after control_concordance_mean,
  add column local_base_rate \
  float(8,6) unsigned DEFAULT NULL COMMENT 'The average base incorporation rate, excluding polymerase pausing events' after control_read_length_mean;
