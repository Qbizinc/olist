SELECT "dbt_jeck_silver__dim_customer_2"."CUSTOMER_UNIQUE_ID",
    "dbt_jeck_silver__dim_customer_2"."CUSTOMER_CITY_STATE",
    COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0) AS "PRICE_SUM",
    CASE
        WHEN COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0) > 2500 THEN 'High'
        ELSE CASE
        WHEN COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0) > 500 THEN 'Medium'
        ELSE 'Low'
        END
    END AS "CUSTOMER_VALUE_BUCKET",
    COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID") AS "ORDER_ID_COUNT_DISTINCT",
    CASE
        WHEN COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID") = 0 THEN NULL
        ELSE COALESCE(COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0), 0) / COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID")
    END AS "AVERAGE_ORDER_VALUE",
    MIN(DATE_TRUNC('DAY', "dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]")) AS "ORDER_PURCHASE_TIMESTAMP_DATE__DATE_MIN",
    MAX(DATE_TRUNC('DAY', "dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]")) AS "ORDER_PURCHASE_TIMESTAMP_DATE__DATE_MAX"
FROM "DBT_JECK_SILVER"."FCT_ORDER_ITEMS" AS "dbt_jeck_silver__fct_order_items"
    LEFT JOIN "DBT_JECK_SILVER"."DIM_CUSTOMER_2" AS "dbt_jeck_silver__dim_customer_2" ON "dbt_jeck_silver__fct_order_items"."CUSTOMER_ID" = "dbt_jeck_silver__dim_customer_2"."CUSTOMER_ID"
GROUP BY 2, 1
