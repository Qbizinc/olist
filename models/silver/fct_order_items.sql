SELECT "dbt_jeck_bronze__stg_olist_order_items"."ORDER_ID",
    "dbt_jeck_bronze__stg_olist_order_items"."ORDER_ITEM_ID",
    "dbt_jeck_bronze__stg_olist_order_items"."PRODUCT_ID",
    "dbt_jeck_bronze__stg_olist_order_items"."SELLER_ID",
    DATE_TRUNC('DAY', "dbt_jeck_bronze__stg_olist_order_items"."SHIPPING_LIMIT_DATE") AS "SHIPPING_LIMIT_DATE[DATE]",
    "dbt_jeck_bronze__stg_olist_order_items"."PRICE",
    "dbt_jeck_bronze__stg_olist_order_items"."FREIGHT_VALUE",
    "dbt_jeck_bronze__stg_olist_orders"."CUSTOMER_ID",
    DATE_TRUNC('DAY', "dbt_jeck_bronze__stg_olist_orders"."ORDER_PURCHASE_TIMESTAMP") AS "ORDER_PURCHASE_TIMESTAMP[DATE]",
    "dbt_jeck_bronze__stg_olist_orders"."ORDER_STATUS",
    "dbt_jeck_bronze__stg_olist_products"."PRODUCT_CATEGORY_NAME_ENGLISH",
    "dbt_jeck_bronze__stg_olist_order_payments"."PAYMENT_TYPE",
    "dbt_jeck_bronze__stg_olist_order_payments"."PAYMENT_VALUE"
FROM "DBT_JECK_BRONZE"."STG_OLIST_ORDER_ITEMS" AS "dbt_jeck_bronze__stg_olist_order_items"
    LEFT JOIN "DBT_JECK_BRONZE"."STG_OLIST_ORDER_PAYMENTS" AS "dbt_jeck_bronze__stg_olist_order_payments" ON "dbt_jeck_bronze__stg_olist_order_items"."ORDER_ID" = "dbt_jeck_bronze__stg_olist_order_payments"."ORDER_ID"
    LEFT JOIN "DBT_JECK_BRONZE"."STG_OLIST_PRODUCTS" AS "dbt_jeck_bronze__stg_olist_products" ON "dbt_jeck_bronze__stg_olist_order_items"."PRODUCT_ID" = "dbt_jeck_bronze__stg_olist_products"."PRODUCT_ID"
    LEFT JOIN "DBT_JECK_BRONZE"."STG_OLIST_ORDERS" AS "dbt_jeck_bronze__stg_olist_orders" ON "dbt_jeck_bronze__stg_olist_order_items"."ORDER_ID" = "dbt_jeck_bronze__stg_olist_orders"."ORDER_ID"
GROUP BY 7, 1, 2, 6, 3, 4, 5, 12, 13, 8, 9, 10, 11
