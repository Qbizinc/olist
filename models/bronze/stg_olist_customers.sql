-- models/bronze/stg_olist_customers.sql
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM {{ source('olist_raw_data', 'customers') }}