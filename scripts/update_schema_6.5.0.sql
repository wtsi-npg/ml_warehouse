-- More detailed comments for some columns.
-- Annotation column reduced to 15 chars since it's not free text.
-- Added column for whole genome yield
-- Added column for phase2 analysis end date
-- Fixed spelling for one column name
ALTER TABLE `iseq_external_product_metrics` \
  MODIFY `qc_status` char(15) DEFAULT NULL \
  COMMENT 'State of the product after phase 2 of processing, one of "PASS", "HOLD", "INSUFFICIENT", "FAIL"',
  MODIFY `qc_overall_assessment` char(4) DEFAULT NULL \
  COMMENT 'State of the product after phase 3 of processing, one of "PASS" or "FAIL"',
  MODIFY `processing_status` char(15) DEFAULT NULL \
  COMMENT 'Overall status of the product, one of "PASS", "HOLD", "INSUFFICIENT", "FAIL"',
  MODIFY `yield` float unsigned DEFAULT NULL \
  COMMENT 'Sequence data quantity (Gb) excluding duplicate reads, adaptors, overlapping bases from reads on the same fragment, soft-clipped bases, non-N autosome only',
  MODIFY `yield_q20` bigint(20) unsigned DEFAULT NULL \
  COMMENT 'Yield in bases at or above Q20 filtered in the same way as the yield column values',
  MODIFY `yield_q30` bigint(20) unsigned DEFAULT NULL \
  COMMENT 'Yield in bases at or above Q30 filtered in the same way as the yield column values',
  MODIFY `num_reads` bigint(20) unsigned DEFAULT NULL \
  COMMENT 'Number of reads filtered in the same way as the yield column values',
  MODIFY `target_proper_pair_mapped_reads_fraction` float unsigned DEFAULT NULL \
  COMMENT 'Fraction of properly paired mapped reads filtered in the same way as the yield column values',
  MODIFY `annotation` varchar(15) DEFAULT NULL \
  COMMENT 'Annotation regarding data provenance, i.e. is sequence data from first pass, re-run, top-up, etc.',
  CHANGE COLUMN `archive_conformation_date` `archive_confirmation_date` \
  date DEFAULT NULL \
  COMMENT 'Date of confirmation of integrity of data product by archive service'
  AFTER `archival_date`,
  ADD COLUMN `yield_whole_genome` float unsigned DEFAULT NULL \
  COMMENT 'Sequence data quantity (Gb) excluding duplicate reads, adaptors, overlapping bases from reads on the same fragment, soft-clipped bases' \
  AFTER `contamination_assessment`,
  ADD COLUMN `phase2_end_date` datetime DEFAULT NULL \
  COMMENT 'Date the phase 2 analysis finished for this product' \
  AFTER `analysis_start_date`;
