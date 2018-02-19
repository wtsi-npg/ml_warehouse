ALTER TABLE `iseq_run_lane_metrics`
ADD COLUMN `tag_hops_percent` FLOAT UNSIGNED DEFAULT NULL
  COMMENT 'Percentage tag hops for dual index runs';
