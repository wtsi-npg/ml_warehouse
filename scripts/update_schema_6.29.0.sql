-- Add plate_number column to the pac_bio_run_well_metrics table

ALTER TABLE `pac_bio_run_well_metrics` \
  ADD COLUMN `plate_number` int(11) DEFAULT NULL COMMENT \
    'The number of the plate that goes onto the Revio sequencing machine. Necessary as an identifier for multi-plate support.' AFTER `well_label`;
