-- Table update for iseq_external_product_metrics to cover for changes
-- in dictionary values

ALTER TABLE `iseq_external_product_metrics`
MODIFY COLUMN `nrd_assessment` CHAR(4) NULL DEFAULT NULL \
COMMENT '\"PASS\" based on nrd_persent < 2% or \"FAIL\" or \"NA\" if genotyping data not available for this sample';
