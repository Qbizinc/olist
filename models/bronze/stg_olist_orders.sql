-- models/bronze/stg_olist_orders.sql
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp::timestamp_ntz AS order_purchase_timestamp,
    order_approved_at::timestamp_ntz AS order_approved_at,
    order_delivered_carrier_date::timestamp_ntz AS order_delivered_carrier_date,
    order_delivered_customer_date::timestamp_ntz AS order_delivered_customer_date,
    order_estimated_delivery_date::timestamp_ntz AS order_estimated_delivery_date
FROM {{ source('olist_raw_data', 'orders') }}