-- compare between 2 datasets from different projects at high level

-- step 1 : change project_id_1 and dataset_id_1
-- step 2 : change project_id_2 and dataset_id_2
-- step 3 : change if needed join condition (Find :"Join condition")
-------------------------------------------
CREATE TEMP FUNCTION diff_in_percentage(final float64, initial float64)
RETURNS float64
AS ( round( if(initial = 0 AND final = 0,
    0, if( initial = 0 AND final != 0,
        100,
        (final - initial) / nullif(initial, 0) * 100)), 1) );
WITH
row_count AS (SELECT
    project_id,
    dataset_id,
    table_id,
    row_count,
    CASE
        WHEN type = 1 THEN "table"
        WHEN type = 2 THEN "view"
    END AS is_table,
    round(size_bytes / pow(10, 9), 1) AS size_gb,
    timestamp_millis(creation_time) AS creation_time,
    timestamp_millis(last_modified_time) AS last_modified_time
    FROM
        (
            SELECT * FROM `project_id_1.dataset_id_1.__TABLES__`
            UNION ALL
            SELECT * FROM `project_id_2.dataset_id_2.__TABLES__`
        )
),

col_count AS (
    SELECT
        table_catalog AS project_id,
        table_schema AS dataset_id,
        table_name AS table_id,
        count(column_name) AS columns_nb,
        array_agg(
            STRUCT(column_name, ordinal_position, is_nullable, data_type)
        ) AS columns_list
    FROM (

        SELECT * FROM
            `project_id_1.dataset_id_1.INFORMATION_SCHEMA.COLUMNS`
        UNION ALL
        SELECT * FROM
           `project_id_2.dataset_id_2.INFORMATION_SCHEMA.COLUMNS`
    )
    GROUP BY 1, 2, 3
),

datasource AS (
    SELECT
        row_count.project_id,
        row_count.dataset_id,
        row_count.table_id,
        row_count.row_count,
        row_count.is_table,
        row_count.size_gb,
        row_count.creation_time,
        row_count.last_modified_time,
        col_count.columns_nb,
        col_count.columns_list
    FROM row_count
    LEFT JOIN
        col_count
        ON row_count.project_id = col_count.project_id
            AND row_count.dataset_id = col_count.dataset_id
            AND row_count.table_id = col_count.table_id
),

datasource_1 AS (
    SELECT * FROM datasource
    WHERE project_id = "project_id_1"
        AND dataset_id = "dataset_id_1"
),

datasource_2 AS (
    SELECT * FROM datasource
    WHERE project_id = "project_id_2"
        AND dataset_id = "dataset_id_2"
),

col_name AS (
    SELECT
        init.project_id,
        init.dataset_id,
        init.table_id,
        list.column_name AS column_name,
        if(final.column_name IS NOT NULL, 1, 0) AS is_present_in_final
    FROM datasource_1 AS init
    LEFT JOIN
        unnest(init.columns_list) AS list
    LEFT JOIN (
        SELECT
            project_id,
            dataset_id,
            table_id,
            list.column_name AS column_name
        FROM datasource_2
        LEFT JOIN unnest(datasource_2.columns_list) AS list) AS final
        -- Join condition to be changed
        ON 
           init.table_id = final.table_id
        -- init.dataset_id = final.dataset_id
            AND list.column_name = final.column_name
),

col_name_agg AS (
    SELECT
        project_id,
        dataset_id,
        table_id,
        sum(is_present_in_final) AS cols_present_in_final,
        array_agg(
            if(is_present_in_final = 0, column_name, NULL) IGNORE NULLS
        ) AS cols_not_present_in_final
    FROM col_name
    GROUP BY project_id, dataset_id, table_id
),

res AS (
    SELECT
        init.is_table,
        init.project_id AS project_id_init,
        final.project_id AS project_id_final,
        init.dataset_id,
        init.table_id,
        init.size_gb AS size_gb_init,
        -- init.creation_time as creation_time_init,
        init.columns_nb AS cols_nb_init,
        final.columns_nb AS cols_nb_final,
        init.row_count AS row_count_init,
        final.row_count AS row_count_final,
        (final.columns_nb - init.columns_nb) AS cols_nb_diff,
        (
            init.columns_nb - col_name_agg.cols_present_in_final
        ) AS cols_nb_real_diff,
        diff_in_percentage(
            final.row_count, init.row_count
        ) AS row_count_diff_perc,
        format_timestamp("%F %T", init.last_modified_time) AS last_modif_init,
        format_timestamp("%F %T", final.last_modified_time) AS last_modif_final,
        timestamp_diff(
            init.last_modified_time, final.last_modified_time, DAY
        ) AS last_modif_diff,
    -- col_name_agg.cols_present_in_final as cols_in_both,
    -- col_name_agg.cols_not_present_in_final,
    -- init.columns_list as columns_list_init,
    -- final.columns_list as columns_list_final,
    FROM
        datasource_1 AS init
    LEFT JOIN
        -- Join condition to be changed
        datasource_2 AS final
        ON init.table_id = final.table_id
        -- AND init.dataset_id = final.dataset_id
    LEFT JOIN col_name_agg
        -- Join condition to be changed
        ON init.table_id = col_name_agg.table_id 
        -- AND init.dataset_id = col_name_agg.dataset_id
-- WHERE final.table_id IS NOT NULL --remove table not present in final env
)

SELECT *
FROM res
-- WHERE 1 = 1
--     -- not iso  
--     AND (
--         res.columns_nb_diff != 0  --different number of columns 
--         OR cols_prod_final_diff != 0 --different columns
--         OR abs(res.row_count_diff_perc) >= 1 ----different number of rows 
--     )

ORDER BY
    abs(row_count_diff_perc) DESC
