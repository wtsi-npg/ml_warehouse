-- Add columns to store QC states for PacBio wells.
-- Allow for preliminary states.

ALTER TABLE `pac_bio_run_well_metrics` \
  ADD COLUMN `qc_seq_state` VARCHAR(255) DEFAULT NULL COMMENT \
    'Current sequencing QC state' AFTER `well_label`, \
  ADD COLUMN `qc_seq_state_is_final` TINYINT(1) DEFAULT NULL COMMENT \
    'A flag marking the sequencing QC state as final (1) or not final (0)' \
    AFTER `qc_seq_state`, \
  ADD COLUMN `qc_seq_date` DATETIME DEFAULT NULL COMMENT \
    'The date the current sequencing QC state was assigned'
     AFTER `qc_seq_state_is_final`, \
  ADD COLUMN `qc_seq` TINYINT(1) DEFAULT NULL COMMENT \
    'The final sequencing QC outcome as 0(failed), 1(passed) or NULL' \
    AFTER `qc_seq_date`, \
  ADD INDEX `pb_rw_qc_state_index` (`qc_seq_state`, `qc_seq_state_is_final`), \
  ADD INDEX `pb_rw_qc_date_index` (`qc_seq_date`);

ALTER TABLE `pac_bio_product_metrics` \
  ADD COLUMN `qc` TINYINT(1) DEFAULT NULL COMMENT \
    'The final QC outcome of the product as 0(failed), 1(passed) or NULL', \
  ADD INDEX `pb_product_qc_index` (`qc`);

-- Drop redundant index. The id_pac_bio_tmp column is the first-named column
-- in the unique key named pac_bio_metrics_product.
ALTER TABLE `pac_bio_product_metrics` \
  DROP INDEX `pac_bio_pr_metrics_to_run_fk`;
   
 
  


