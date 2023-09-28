-- step 1 : change project_id and dataset_id

SELECT
    table_catalog,
    table_schema,
    table_name,
    column_name,
    data_type
FROM `project_id.dataset_id.INFORMATION_SCHEMA.COLUMNS`
-- WHERE column_name like 'MY_COL'
