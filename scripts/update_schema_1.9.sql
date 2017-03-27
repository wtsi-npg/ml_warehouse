ALTER TABLE `iseq_run_lane_metrics`
ADD COLUMN `run_priority` TINYINT(3) DEFAULT NULL
  COMMENT 'Sequencing lane level run priority, a result of either manual or default value set by core'
  AFTER `unexpected_tags_percent`;
