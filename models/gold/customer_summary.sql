SELECT "dbt_jeck_silver__dim_customer"."CUSTOMER_UNIQUE_ID",
    COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0) AS "PRICE_SUM",
    COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID") AS "ORDER_ID_COUNT_DISTINCT",
    MIN(DATE_TRUNC('DAY', "dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]")) AS "ORDER_PURCHASE_TIMESTAMP_DATE__DATE_MIN",
    MAX(DATE_TRUNC('DAY', "dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]")) AS "ORDER_PURCHASE_TIMESTAMP_DATE__DATE_MAX",
    CASE
        WHEN COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID") = 0 THEN NULL
        ELSE COALESCE(COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0), 0) / COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID")
    END AS "AVERAGE_ORDER_VALUE_1"
FROM {{ref('fct_order_items')}} AS "dbt_jeck_silver__fct_order_items"
    LEFT JOIN {{ref('dim_customer')}} AS "dbt_jeck_silver__dim_customer" ON "dbt_jeck_silver__fct_order_items"."CUSTOMER_ID" = "dbt_jeck_silver__dim_customer"."CUSTOMER_ID"
GROUP BY 1
