ALTER TABLE `iseq_product_metrics` \
ADD COLUMN `qc_seq` TINYINT(1) DEFAULT NULL \
  COMMENT 'Sequencing lane level QC outcome, a result of either manual or automatic assessment by core' \
  AFTER `tag_index`, \
ADD COLUMN `qc_lib` TINYINT(1) DEFAULT NULL \
  COMMENT 'Library QC outcome, a result of either manual or automatic assessment by core' \
  AFTER `qc_seq`, \
ADD COLUMN `qc`     TINYINT(1) DEFAULT NULL \
  COMMENT 'Overall QC assessment outcome, a logical product (conjunction) of qc_seq and qc_lib values, defaults to the qc_seq value when qc_lib is not defined'
  AFTER `qc_lib`;
