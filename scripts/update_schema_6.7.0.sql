ALTER TABLE iseq_product_metrics \
  ADD COLUMN `qc_user` TINYINT(1) DEFAULT NULL \
  COMMENT 'Library QC outcome according to the data user criteria, a result of either manual or automatic assessment' \
  AFTER `qc_lib`;