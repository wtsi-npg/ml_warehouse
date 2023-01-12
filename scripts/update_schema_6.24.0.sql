--
-- Set up search indexes.
--
-- The choice of columns is driven by the LangQC retrival query
-- for the QC inbox.
-- Note the explicit ascending order for indexes on the run_complete
-- and well_complete columns. These indexes are suboptimal for queries
-- that require a sort in descending order on the values in these
-- columns. A separate index can be added to support the reverse order
-- sort. 

ALTER TABLE pac_bio_run_well_metrics \
  ADD INDEX `pbrw_movie_name_index` (`movie_name`), \
  ADD INDEX `pbrw_ccs_execmode_index` (`ccs_execution_mode`), \
  ADD INDEX `pbrw_run_complete_index` (`run_complete` ASC), \
  ADD INDEX `pbrw_well_complete_index` (`well_complete` ASC); 

