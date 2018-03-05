-- The remaining index on (id_run, position, tag_index)
-- will provide effective indexing for the columns
-- (id_run, position).
drop index iseq_pm_run_pos_index on iseq_product_metrics;
drop index iseq_pr_metrics_lm_fk on iseq_product_metrics;
