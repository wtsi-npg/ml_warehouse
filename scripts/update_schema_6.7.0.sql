ALTER TABLE iseq_product_metrics \
  ADD COLUMN `qc_user` TINYINT(1) DEFAULT NULL \
  COMMENT 'Library QC outcome according to the data user criteria, a result of either manual or automatic assessment' \
  AFTER `qc_lib`;

ALTER TABLE iseq_external_product_metrics \
  ADD COLUMN `destination` VARCHAR(15) DEFAULT 'UKBMP' \
  COMMENT 'Data destination, defaults to "UKBMP"' \
  AFTER `id_archive_product`;

