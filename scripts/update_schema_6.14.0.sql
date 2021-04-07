alter table pac_bio_run_well_metrics \
  add column hifi_read_bases \
  bigint unsigned DEFAULT NULL COMMENT 'The number of HiFi bases' after short_insert_percent, \
  add column hifi_num_reads \
  int unsigned DEFAULT NULL COMMENT 'The number of HiFi reads' after hifi_read_bases, \
  add column hifi_read_length_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean HiFi read length' after hifi_num_reads , \
  add column hifi_read_quality_median \
  smallint unsigned DEFAULT NULL COMMENT 'The median HiFi base quality' after hifi_read_length_mean, \
  add column hifi_number_passes_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean number of passes per HiFi read' after hifi_read_quality_median, \
  add column hifi_low_quality_read_bases \
  bigint unsigned DEFAULT NULL COMMENT 'The number of HiFi bases filtered due to low quality (<Q20)' after hifi_number_passes_mean, \
  add column hifi_low_quality_num_reads \
  int unsigned DEFAULT NULL COMMENT 'The number of HiFi reads filtered due to low quality (<Q20)' after hifi_low_quality_read_bases, \
  add column hifi_low_quality_read_length_mean \
  int unsigned DEFAULT NULL COMMENT 'The mean length of HiFi reads filtered due to low quality (<Q20)' after hifi_low_quality_num_reads, \
  add column hifi_low_quality_read_quality_median \
  smallint unsigned DEFAULT NULL COMMENT 'The median base quality of HiFi bases filtered due to low quality (<Q20)' after hifi_low_quality_read_length_mean;
