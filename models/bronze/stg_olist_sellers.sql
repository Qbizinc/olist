-- models/bronze/stg_olist_sellers.sql
SELECT
    seller_id,
    seller_city,
    seller_state,
    seller_zip_code_prefix
FROM {{ source('olist_raw_data', 'sellers') }}