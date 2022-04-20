ALTER TABLE pac_bio_run_well_metrics 
  ADD COLUMN `sl_hostname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL 
    COMMENT 'SMRT Link server hostname' 
    AFTER `chip_type`, 
  ADD COLUMN `sl_run_uuid` varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL 
    COMMENT 'SMRT Link specific run uuid' 
    AFTER `sl_hostname`, 
  ADD COLUMN `movie_minutes` SMALLINT(5) UNSIGNED DEFAULT NULL 
    COMMENT 'Movie time (collection time) in minutes' 
    AFTER `movie_name`, 
  ADD COLUMN `binding_kit` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL 
    COMMENT 'Binding kit version' 
    AFTER `movie_minutes`, 
  ADD COLUMN `sequencing_kit` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
    COMMENT 'Sequencing kit version' 
    AFTER `binding_kit`, 
  ADD COLUMN `sequencing_kit_lot_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL 
    COMMENT 'Sequencing Kit lot number' 
    AFTER `sequencing_kit`, 
  ADD COLUMN `created_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL 
    COMMENT 'Created by user name recorded in SMRT Link' 
    AFTER `movie_minutes`, 
  ADD COLUMN `include_kinetics` TINYINT(1) UNSIGNED DEFAULT NULL 
    COMMENT 'Include kinetics information where ccs is run' 
    AFTER `ccs_execution_mode`, 
  ADD COLUMN `loading_conc` float UNSIGNED DEFAULT NULL 
    COMMENT 'SMRT Cell loading concentration (pM)' 
    AFTER `include_kinetics`, 
  ADD COLUMN `control_concordance_mode` float unsigned DEFAULT NULL 
    COMMENT 'The modal value from the concordance between the control raw reads and the control reference sequence' 
    AFTER control_concordance_mean;
