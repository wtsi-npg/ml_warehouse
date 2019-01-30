ALTER TABLE iseq_product_metrics \
ADD COLUMN `nrd_percent` FLOAT(5,2) DEFAULT NULL \
  COMMENT 'Percent of non-reference discordance' \
  AFTER `gbs_pass_rate`;