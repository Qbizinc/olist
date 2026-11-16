-- models/silver/fct_fx_rate_daily.sql
-- One row per calendar day. ECB publishes business days only, so weekends and holidays carry
-- the last published rate forward (is_published_rate = FALSE on those days).
WITH bounds AS (
    SELECT MIN(rate_date) AS min_date, MAX(rate_date) AS max_date
    FROM {{ ref('stg_fx_rates_brl') }}
),

day_offsets AS (
    SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1 AS day_offset
    FROM TABLE(GENERATOR(ROWCOUNT => 20000))
),

calendar AS (
    SELECT DATEADD('day', day_offsets.day_offset, bounds.min_date) AS rate_date
    FROM bounds
    CROSS JOIN day_offsets
    WHERE DATEADD('day', day_offsets.day_offset, bounds.min_date) <= bounds.max_date
)

SELECT
    calendar.rate_date,
    LAST_VALUE(fx.usd_per_brl) IGNORE NULLS OVER (
        ORDER BY calendar.rate_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS usd_per_brl,
    fx.usd_per_brl IS NOT NULL AS is_published_rate
FROM calendar
LEFT JOIN {{ ref('stg_fx_rates_brl') }} AS fx
    ON calendar.rate_date = fx.rate_date
