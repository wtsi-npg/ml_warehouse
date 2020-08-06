ALTER TABLE `iseq_heron_product_metrics` \
  ADD COLUMN `pp_name` VARCHAR(40) DEFAULT 'ncov2019-artic-nf' \
    COMMENT 'The name of the pipeline that produced the QC metric' \
    AFTER `supplier_sample_name`, \
  ADD COLUMN `pp_version` VARCHAR(40) DEFAULT NULL \
    COMMENT 'The version of the pipeline specified in the pp_name column' \
    AFTER `pp_name`, \
  ADD KEY `iseq_hrm_idrun` (`id_run`), \
  ADD KEY `iseq_hrm_ppver` (`pp_version`);
