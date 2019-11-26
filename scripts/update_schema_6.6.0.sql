ALTER TABLE `iseq_run_lane_metrics` \
  ADD COLUMN `instrument_external_name` char(10) DEFAULT NULL \
  COMMENT 'Name assigned to the instrument by the manufacturer' \
  AFTER `instrument_name`;
