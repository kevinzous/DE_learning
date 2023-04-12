--compare between different datasets at high level

-- step 1 : change project_id_1 and dataset_id_1
-- step 2 : change project_id_2 and dataset_id_2

WITH source AS (
    SELECT * FROM `project_id_1.dataset_id_1.__TABLES__`
    UNION ALL
    SELECT * FROM `project_id_2.dataset_id_2.__TABLES__`
)

SELECT
    project_id,
    dataset_id,
    table_id,
    row_count,
    CASE
        WHEN type = 1 THEN 'table'
        WHEN type = 2 THEN 'view'
    END AS category,
    ROUND(size_bytes / POW(10, 9), 1) AS size_gb,
    DATE(TIMESTAMP_MILLIS(creation_time)) AS created,
    DATE(TIMESTAMP_MILLIS(last_modified_time)) AS last_modified
FROM source
ORDER BY last_modified
