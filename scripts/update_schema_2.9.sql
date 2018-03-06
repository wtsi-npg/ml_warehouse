-- The remaining index on (id_run, position, tag_index)
-- will provide effective indexing for the columns
-- (id_run, position).
ALTER TABLE iseq_product_metrics DROP INDEX iseq_pm_run_pos_index, DROP INDEX iseq_pr_metrics_lm_fk;
