ALTER TABLE iseq_product_metrics
ADD COLUMN `id_iseq_product` CHAR(64) DEFAULT NULL \
  COMMENT 'Product id' \
  AFTER `id_iseq_pr_metrics_tmp`,
ADD COLUMN `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
  COMMENT 'Date this record was created or changed' \
  AFTER `id_iseq_product`,
ADD COLUMN `iseq_composition_tmp` VARCHAR(300) DEFAULT NULL \
  COMMENT 'JSON representation of the composition object, the column might be deleted in future' \
  AFTER `tag_index`,
MODIFY COLUMN `id_run` INT(10) UNSIGNED DEFAULT NULL \
  COMMENT 'NPG run identifier',
MODIFY COLUMN `position` SMALLINT(2) UNSIGNED DEFAULT NULL \
  COMMENT 'Flowcell lane number',
DROP KEY `iseq_pm_run_index`,
ADD KEY `iseq_pr_metrics_product_index` (`id_iseq_product`);

ALTER TABLE iseq_run_lane_metrics
ADD COLUMN `last_changed` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP \
  COMMENT 'Date this record was created or changed' \
  AFTER `position`,
ADD COLUMN `qc_seq` TINYINT(1) DEFAULT NULL \
  COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core' \
  AFTER `last_changed`;
