ALTER TABLE `iseq_heron_product_metrics` \
  ADD COLUMN `id_run` INT(10) UNSIGNED DEFAULT NULL COMMENT 'Run id' AFTER `last_changed`, \
  DROP FOREIGN KEY `iseq_hrm_prm_fk`;

