-- Add uuid for ccs data set to allow linking from LangQC.

ALTER table `pac_bio_run_well_metrics` \
  ADD COLUMN `sl_ccs_uuid`  varchar(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL \
  COMMENT 'SMRT Link specific ccs dataset uuid' \
  AFTER `sl_run_uuid`;
