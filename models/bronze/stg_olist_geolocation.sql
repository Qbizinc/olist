-- models/bronze/stg_olist_geolocation.sql
SELECT
    geolocation_city, 
    geolocation_lat, 
    geolocation_lng, 
    geolocation_state, 
    geolocation_zip_code_prefix
FROM {{ source('olist_raw_data', 'geolocation') }}