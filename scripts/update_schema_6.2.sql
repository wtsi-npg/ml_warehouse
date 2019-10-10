-- Table update for iseq_external_product_metrics to cover for changes to
-- FastQC Processing.
-- Rename qc column
-- New column for qc status

ALTER TABLE `iseq_external_product_metrics`
MODIFY COLUMN `adapter_contamination` VARCHAR(255) NULL DEFAULT NULL COMMENT 'The maximum over adapters and cycles in reads/fragments as a fraction per file and RG. Values for first and second reads separated with \",\", and values for individual files separated with \"/\". e.g. \"0.1/0.1/0.1/0.1,0.1/0.1/0.1/0.1\"' ,
MODIFY COLUMN `adapter_contamination_assessment` VARCHAR(255) NULL DEFAULT NULL COMMENT '\"PASS\", \"WARN\", \"FAIL\" per read and file. Multiple values are represented as forward slash-separated array of strings with a comma separating entries for paired-end 1 and 2 reads e.g. \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `basic_statistics_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `overrepresented_sequences_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `n_content_per_base_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `sequence_content_per_base_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `sequence_quality_per_base_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `gc_content_per_sequence_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `quality_scores_per_sequence_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `sequence_duplication_levels_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `sequence_length_distribution_assessement` VARCHAR(255) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\", \"WARN\", \"FAIL\" per input file. Array of strings separated by \"/\", with a \",\" separating entries for paired-end 1 and 2 reads. e.g. Four RG \"PASS/PASS/WARN/PASS,PASS/PASS/WARN/PASS\"' ,
MODIFY COLUMN `FastQC_overall_assessment` CHAR(4) NULL DEFAULT NULL COMMENT 'FastQC \"PASS\" or \"FAIL\"' ,
MODIFY COLUMN `insert_size_mean` FLOAT UNSIGNED NULL DEFAULT NULL ,
MODIFY COLUMN `insert_size_std` FLOAT UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `qc` `qc_overall_assessment` CHAR(4) NULL DEFAULT NULL COMMENT 'Final data product criteria evaluation outcome as \"PASS\" or \"FAIL\"' ,
CHANGE COLUMN `sex_supplier` `sex_reported` CHAR(6) NULL DEFAULT NULL COMMENT 'Sex as reported by sample supplier' ,
ADD COLUMN `qc_status` CHAR(15) NULL DEFAULT NULL COMMENT 'One of \"PASS\", \"HOLD\", \"INSUFFICIENT\", \"FAIL\"' AFTER `qc_overall_assessment`;
