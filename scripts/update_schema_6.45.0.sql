
-- Add columns to capture multi-use cell information relating to the new SPRQ-Nx consumables.

ALTER TABLE `pac_bio_run_well_metrics` \
  ADD COLUMN `is_cell_multi_use` TINYINT(1) NOT NULL DEFAULT '0' \
    COMMENT 'Is the Revio SMRT Cell a multi-use Cell (available since SMRT Link 25.4).' \
    AFTER `loading_conc`;

ALTER TABLE `pac_bio_run_well_metrics` \
  ADD COLUMN `cell_use_count` SMALLINT UNSIGNED DEFAULT NULL \
    COMMENT 'The number of times a SMRT Cell has been used (available since SMRT Link 25.4).' \
    AFTER `is_cell_multi_use`;

ALTER TABLE `pac_bio_run_well_metrics` \
  ADD COLUMN `cell_id` VARCHAR(255) DEFAULT NULL \
    COMMENT 'The SMRT Cell unique identifier (available since SMRT Link 25.4).' \
    AFTER `cell_use_count`;
