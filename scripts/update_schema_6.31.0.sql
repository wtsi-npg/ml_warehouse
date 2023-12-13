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
