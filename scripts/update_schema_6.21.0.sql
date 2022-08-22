
 -- Add extra columns to pac_bio_run_well_metrics to support downstream analysis
ALTER TABLE pac_bio_run_well_metrics
   ADD `run_tranfer_complete` datetime DEFAULT NULL COMMENT 'Timestamp of run transfer complete'
   AFTER `run_complete`;
