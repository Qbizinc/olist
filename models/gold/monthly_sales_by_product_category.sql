SELECT DATE_TRUNC('DAY', "ORDER_PURCHASE_TIMESTAMP[DATE]") AS "ORDER_PURCHASE_TIMESTAMP_DATE_[DATE]",
    DATE_TRUNC('YEAR', "ORDER_PURCHASE_TIMESTAMP[DATE]") AS "ORDER_PURCHASE_TIMESTAMP_DATE_[YEAR]",
    TO_CHAR("ORDER_PURCHASE_TIMESTAMP[DATE]", 'MMMM') AS "ORDER_PURCHASE_TIMESTAMP_DATE_[MONTH_NAME]",
    "PRODUCT_CATEGORY_NAME_ENGLISH",
    COALESCE(SUM("PRICE"), 0) AS "PRICE_SUM",
    COUNT(DISTINCT "ORDER_ID") AS "ORDER_ID_COUNT_DISTINCT",
    EXTRACT(MONTH FROM "ORDER_PURCHASE_TIMESTAMP[DATE]") AS "ORDER_PURCHASE_TIMESTAMP_DATE_[MONTH_NAME]__OMNI_SORT"
FROM {{ref('fct_order_items')}} AS "dbt_jeck_silver__fct_order_items"
GROUP BY 1, 3, 2, 4, 7
