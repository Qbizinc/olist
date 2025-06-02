SELECT DATE_TRUNC('YEAR', "dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]") AS "ORDER_PURCHASE_TIMESTAMP_DATE_[YEAR]",
    TO_CHAR("dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]", 'MMMM') AS "ORDER_PURCHASE_TIMESTAMP_DATE_[MONTH_NAME]",
    "dbt_jeck_silver__dim_product"."PRODUCT_CATEGORY_NAME_ENGLISH",
    COALESCE(SUM("dbt_jeck_silver__fct_order_items"."PRICE"), 0) AS "PRICE_SUM",
    COUNT(DISTINCT "dbt_jeck_silver__fct_order_items"."ORDER_ID") AS "ORDER_ID_COUNT_DISTINCT",
    COALESCE(SUM("dbt_jeck_silver__fct_order_items"."ORDER_ITEM_ID"), 0) AS "ORDER_ITEM_ID_SUM",
    EXTRACT(MONTH FROM "dbt_jeck_silver__fct_order_items"."ORDER_PURCHASE_TIMESTAMP[DATE]") AS "ORDER_PURCHASE_TIMESTAMP_DATE_[MONTH_NAME]__OMNI_SORT"
FROM "DBT_JECK_SILVER"."FCT_ORDER_ITEMS" AS "dbt_jeck_silver__fct_order_items"
    LEFT JOIN "DBT_JECK_SILVER"."DIM_PRODUCT" AS "dbt_jeck_silver__dim_product" ON "dbt_jeck_silver__fct_order_items"."PRODUCT_ID" = "dbt_jeck_silver__dim_product"."PRODUCT_ID"
GROUP BY 3, 2, 1, 7
