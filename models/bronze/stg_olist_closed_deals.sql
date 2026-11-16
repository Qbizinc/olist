-- models/bronze/stg_olist_closed_deals.sql
-- One row per closed deal (an MQL that became a seller). Keep the latest load per MQL.
SELECT
    mql_id,
    seller_id,
    sdr_id,
    sr_id,
    won_date,
    COALESCE(business_segment, 'unknown') AS business_segment,
    COALESCE(lead_type, 'unknown') AS lead_type,
    COALESCE(lead_behaviour_profile, 'unknown') AS lead_behaviour_profile,
    has_company,
    has_gtin,
    average_stock,
    COALESCE(business_type, 'unknown') AS business_type,
    declared_product_catalog_size,
    declared_monthly_revenue,
    _loaded_at
FROM {{ source('olist_airflow', 'af_closed_deals') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY mql_id ORDER BY _loaded_at DESC) = 1
