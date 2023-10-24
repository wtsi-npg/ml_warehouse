ALTER TABLE `pac_bio_run_well_metrics`
  ADD COLUMN `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE \
  CURRENT_TIMESTAMP COMMENT 'Date this record was created or changed';

ALTER TABLE `pac_bio_product_metrics`
  ADD COLUMN `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE \
  CURRENT_TIMESTAMP COMMENT 'Date this record was created or changed';
