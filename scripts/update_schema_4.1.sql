--
-- Add new columns to iseq_product_metrics table
--

ALTER TABLE `iseq_product_metrics` \
ADD COLUMN target_autosome_coverage_threshold int(4) DEFAULT NULL \
  COMMENT 'The coverage threshold used in the perc target autosome greater than depth calculation' \
  AFTER target_percent_gt_coverage_threshold, \
ADD COLUMN target_autosome_percent_gt_coverage_threshold float(5,2) DEFAULT NULL \
  COMMENT 'The percentage of the target autosome covered at greater than the depth specified' \
  AFTER target_autosome_coverage_threshold;
