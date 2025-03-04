--
-- Add a column to iseq_run_lane_metrics to capture the time the lane
-- is released, ie QC-ed and archived.
--
ALTER TABLE `iseq_run_lane_metrics` \
  ADD COLUMN `lane_released` datetime DEFAULT NULL \
  COMMENT 'The date the lane was released, ie QC-ed and fully archived' \
  AFTER `run_complete`;
