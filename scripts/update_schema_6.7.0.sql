ALTER TABLE iseq_product_metrics \
  ADD COLUMN `qc_user` TINYINT(1) DEFAULT NULL \
  COMMENT 'Library QC outcome according to the data user criteria, a result of either manual or automatic assessment' \
  AFTER `qc_lib`;

ALTER TABLE iseq_external_product_metrics \
  ADD COLUMN `destination` VARCHAR(15) DEFAULT 'UKBMP' \
  COMMENT 'Data destination, defaults to "UKBMP"' \
  AFTER `id_archive_product`;

ALTER TABLE iseq_run_lane_metrics \
  ADD COLUMN `interop_cluster_count_total` BIGINT UNSIGNED DEFAULT NULL \
    COMMENT 'Total cluster count for this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_count_mean` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Total cluster count, mean value over tiles of this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_count_stdev` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Standard deviation value for interop_cluster_count_mean', \
  ADD COLUMN `interop_cluster_count_pf_total` BIGINT UNSIGNED DEFAULT NULL \
    COMMENT 'Purity-filtered cluster count for this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_count_pf_mean` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Purity-filtered cluster count, mean value over tiles of this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_count_pf_stdev` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Standard deviation value for interop_cluster_count_pf_mean', \
  ADD COLUMN `interop_cluster_density_mean` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Cluster density, mean value over tiles of this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_density_stdev` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Standard deviation value for interop_cluster_density_mean', \
  ADD COLUMN `interop_cluster_density_pf_mean` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Purity-filtered cluster density, mean value over tiles of this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_density_pf_stdev` DOUBLE UNSIGNED DEFAULT NULL \
    COMMENT 'Standard deviation value for interop_cluster_density_pf_mean', \
  ADD COLUMN `interop_cluster_pf_mean` FLOAT(5,2) UNSIGNED DEFAULT NULL \
    COMMENT ' Percent of purity-filtered clusters, mean value over tiles of this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_cluster_pf_stdev` FLOAT(5,2) UNSIGNED DEFAULT NULL \
    COMMENT 'Standard deviation value for interop_cluster_pf_mean', \
  ADD COLUMN `interop_occupied_mean` FLOAT(5,2) UNSIGNED DEFAULT NULL \
    COMMENT 'Percent of occupied flowcell wells, a mean value over tiles of this lane (derived from Illumina InterOp files)', \
  ADD COLUMN `interop_occupied_stdev` FLOAT(5,2) UNSIGNED DEFAULT NULL \
    COMMENT 'Standard deviation value for interop_occupied_mean';
