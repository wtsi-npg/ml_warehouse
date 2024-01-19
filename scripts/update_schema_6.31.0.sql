-- Add columns for metrics useful for BGE project.

ALTER TABLE `iseq_product_metrics` \
  ADD COLUMN `mean_bait_target_coverage` float DEFAULT NULL \
    COMMENT 'Mean coverage of the design target regions of a bait library (if used and known)' \
    AFTER `on_or_near_bait_percent`, \
  ADD COLUMN `target_autosome_filter` varchar(30) DEFAULT NULL \
    COMMENT 'Filter used to produce the autosome target stats file' \
    AFTER `target_percent_gt_coverage_threshold`, \
  ADD COLUMN `target_autosome_length` bigint unsigned DEFAULT NULL \
    COMMENT 'The total length of the autosomes only target regions' \
    AFTER `target_autosome_filter`, \
  ADD COLUMN `target_autosome_mapped_bases` bigint unsigned DEFAULT NULL \
    COMMENT 'The number of mapped bases passing the autosome target filters' \
    AFTER `target_autosome_length`;


-- Add columns to pac_bio_product_metrics to store tag level yield.

ALTER TABLE `pac_bio_product_metrics` \
  ADD COLUMN  `hifi_read_bases`  bigint unsigned DEFAULT NULL \
    COMMENT 'The number of HiFi bases' \
    AFTER `qc`, \
  ADD COLUMN  `hifi_num_reads` int unsigned DEFAULT NULL \
    COMMENT 'The number of HiFi reads' \
    AFTER `hifi_read_bases`, \
  ADD COLUMN  `hifi_read_length_mean` int unsigned DEFAULT NULL \
    COMMENT 'The mean HiFi read length' \
    AFTER `hifi_num_reads`, \
  ADD COLUMN  `hifi_read_quality_mean` smallint unsigned DEFAULT NULL \
    COMMENT 'The mean HiFi base quality' \
    AFTER  `hifi_read_length_mean`, \
  ADD COLUMN  `hifi_bases_percent` float DEFAULT NULL \
    COMMENT 'The HiFi bases expressed as a percentage of the total HiFi bases' \
    AFTER  `hifi_read_quality_mean`, \
  ADD COLUMN  `barcode_quality_score_mean` smallint unsigned DEFAULT NULL \
    COMMENT 'The mean barcode HiFi quality score' \
    AFTER `hifi_read_length_mean`;
