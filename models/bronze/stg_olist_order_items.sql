-- models/bronze/stg_olist_order_items.sql
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date::timestamp_ntz AS shipping_limit_date,
    price::number(10,2) AS price,
    freight_value::number(10,2) AS freight_value
FROM {{ source('olist_raw_data', 'order_items') }}