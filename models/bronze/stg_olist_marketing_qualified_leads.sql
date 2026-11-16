-- models/bronze/stg_olist_marketing_qualified_leads.sql
-- One row per MQL. Airflow's COPY can load a re-delivered file twice; keep the latest load.
SELECT
    mql_id,
    first_contact_date,
    landing_page_id,
    COALESCE(NULLIF(TRIM(origin), ''), 'unknown') AS origin,
    _loaded_at
FROM {{ source('olist_airflow', 'af_marketing_qualified_leads') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY mql_id ORDER BY _loaded_at DESC) = 1
