-- models/bronze/stg_olist_order_payments.sql
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value::number(10,2) AS payment_value
FROM {{ source('olist_raw_data', 'olist_order_payments_dataset') }}