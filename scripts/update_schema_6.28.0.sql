-- Add columns relating to cell level deplexing to the
-- pac_bio_run_well_metrics table

ALTER TABLE `pac_bio_run_well_metrics` \
  ADD COLUMN `demultiplex_mode` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT \
    'Demultiplexing mode e.g. OnInstument, OffInstument or None' AFTER `ccs_execution_mode`, \
  ADD COLUMN `hifi_barcoded_reads` int(10) unsigned  DEFAULT NULL COMMENT \
    'Number of reads with an expected barcode in demultiplexed HiFi data' AFTER `hifi_low_quality_read_quality_median`, \
  ADD COLUMN `hifi_bases_in_barcoded_reads` bigint(20) unsigned DEFAULT NULL COMMENT \
    'Number of bases in reads with an expected barcode in demultiplexed HiFi data' AFTER `hifi_barcoded_reads`;
