-- models/bronze/stg_fx_rates_brl.sql
-- One row per business day: how many USD one BRL buys.
SELECT
    rate_date,
    rate AS usd_per_brl,
    source,
    _loaded_at
FROM {{ source('olist_airflow', 'af_fx_rates_brl') }}
WHERE base_currency = 'BRL'
  AND quote_currency = 'USD'
QUALIFY ROW_NUMBER() OVER (PARTITION BY rate_date ORDER BY _loaded_at DESC) = 1
