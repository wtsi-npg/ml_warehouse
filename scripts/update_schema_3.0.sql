ALTER TABLE iseq_product_metrics
ADD COLUMN `id_iseq_sample_tmp` INT(10)    UNSIGNED DEFAULT NULL AFTER `id_iseq_flowcell_tmp` \
  COMMENT 'Sample id, see "sample.id_sample_tmp"',
ADD COLUMN `id_iseq_study_tmp`  INT(10)    UNSIGNED DEFAULT NULL AFTER `id_iseq_sample_tmp`   \
  COMMENT 'Study id, see "study.id_study_tmp"',
ADD COLUMN `id_iseq_product`    CHAR(64)            DEFAULT NULL AFTER `tag_index`            \
  COMMENT 'Product id',
ADD COLUMN `is_merged`          TYNIINT(1) UNSIGNED DEFAULT 0    AFTER `id_iseq_product`      \
  COMMENT 'A boolean flag, true if the product is the outcome of a merge of other products',
ADD COLUMN `date_created`       DATETIME            DEFAULT NULL AFTER `is_merged`            \
  COMMENT 'Date this record created/recreated',
ADD COLUMN `date_updated`       DATETIME            DEFAULT NULL AFTER `date_created`         \
  COMMENT 'Date this record updated',
ADD KEY `iseq_pr_metrics_sample_fk` (`id_iseq_sample_tmp`),
ADD KEY `iseq_pr_metrics_study_fk` (`id_iseq_study_tmp`),
ADD KEY `iseq_pr_metrics_product` (`id_iseq_product`),
ADD CONSTRAINT `iseq_pr_sample_fk` FOREIGN KEY (`id_iseq_sample_tmp`) \
  REFERENCES `sample` (`id_sample_tmp`) ON DELETE SET NULL ON UPDATE NO ACTION,
ADD CONSTRAINT `iseq_pr_study_fk`  FOREIGN KEY (`id_iseq_study_tmp`)  \
  REFERENCES `study` (`id_study_tmp`)   ON DELETE SET NULL ON UPDATE NO ACTION;