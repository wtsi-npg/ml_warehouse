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
  
-- Create a new table. 
create table gsu_sample_uploads (
    id_gsu_sample_upload_tmp int(10) unsigned not null auto_increment comment 'Row ID',
    created datetime default current_timestamp comment 'Datetime this record was created',
    last_changed datetime default current_timestamp on update current_timestamp comment 'Datetime this record was last updated',
    file_path varchar(255) not null comment 'Location of data file',
    id_study_tmp int(10) unsigned not null comment 'Study for this item',
    id_sample_tmp int(10) unsigned not null comment 'Sample info for this item',
    library_name varchar(40) not null comment 'Supplier library name',
    library_type varchar(40) not null comment 'Library type',
    instrument_model varchar(40) not null comment 'Sequencing machine used',
    lab_name varchar(100) not null comment 'Lab supplying the data',
    run_accession varchar(40) comment 'ENA run accession, populated on ENA submission',
    unique key gsu_su_file_path_unq (file_path),
    unique key gsu_su_run_accession (run_accession),
    primary key gsu_su_primary (id_gsu_sample_upload_tmp),
    key gsu_su_study (id_study_tmp),
    key gsu_su_sample (id_sample_tmp),
    constraint gsu_su_study_fk foreign key (id_study_tmp) references study (id_study_tmp),
    constraint gsu_su_sample_fk foreign key (id_sample_tmp) references sample (id_sample_tmp)
); 
  


