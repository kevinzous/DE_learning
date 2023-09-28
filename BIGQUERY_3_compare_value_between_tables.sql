-- step 1 : change project_id_1 and dataset_id_1
-- step 2 : change project_id_2 and dataset_id_2

WITH
left_data AS (
    SELECT
        table_1 AS table_data,
        FARM_FINGERPRINT(FORMAT("%T", table_1)) AS h
    FROM
        /****************TABLE A CHANGER****************/
        `project_id_1.dataset_id_1.table_id_1` AS table_1
),

right_data AS (
    SELECT
        table_2 AS table_data,
        FARM_FINGERPRINT(FORMAT("%T", table_2)) AS h
    FROM
        /****************TABLE A CHANGER****************/
        `project_id_2.dataset_id_2.table_id_2` AS table_2
)

SELECT
    IF(l.h IS NULL, "New on right", "New on left") AS change,
    IF(l.h IS NULL, r.table_data, l.table_data).* -- noqa
FROM
    left_data AS l
FULL OUTER JOIN
    right_data AS r
    ON l.h = r.h
WHERE
    l.h IS NULL OR r.h IS NULL
