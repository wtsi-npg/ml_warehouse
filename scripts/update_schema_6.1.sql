ALTER TABLE `iseq_external_product_metrics`
  DROP KEY `iseq_ext_pr_sample_name`,
  DROP KEY `iseq_ext_pr_metrics_pr_file_name`,
  MODIFY COLUMN `manifest_upload_status` char(15) DEFAULT NULL \
    COMMENT 'One of "IN PROGRESS", "DONE", "FAIL", not set for multiple source files',
  CHANGE COLUMN `manifest_upload_date` `manifest_upload_status_change_date` \
    datetime DEFAULT NULL \
    COMMENT 'Date the status of manifest upload is changed',
  CHANGE COLUMN `supplier_sample_name_wsi` `sample_id_wsi` varchar(255) DEFAULT NULL,
  MODIFY COLUMN `plate_id_wsi` varchar(255) DEFAULT NULL,
  MODIFY COLUMN `md5_wsi` char(32) DEFAULT NULL \
    COMMENT 'WSI validation hex MD5, not set for multiple source files',
  ADD COLUMN `library_id_wsi` int(11) DEFAULT NULL \
    AFTER `plate_id_wsi`,
  MODIFY COLUMN `md5` char(32) DEFAULT NULL \
    COMMENT 'External validation hex MD5, not set for multiple source files',
  ADD KEY `iseq_ext_pr_fname` (`file_name_wsi`),
  ADD KEY `iseq_ext_pr_lib_id` (`library_id_wsi`),
  ADD KEY `iseq_ext_pr_sample_id` (`sample_id_wsi`);
