-- models/gold/seller_acquisition_funnel.sql
-- Monthly MQL cohorts by origin: how many leads closed, how fast, and what the sellers they
-- brought in went on to sell. Sales come from item-grain staging (one row per order item), so
-- this GMV does not carry FCT_ORDER_ITEMS' payment fan-out.
WITH seller_sales AS (
    SELECT
        seller_id,
        COUNT(DISTINCT order_id) AS orders,
        SUM(price) AS gmv_brl
    FROM {{ ref('stg_olist_order_items') }}
    GROUP BY seller_id
)

SELECT
    mql.first_contact_month,
    mql.origin,
    COUNT(*) AS mqls,
    COUNT_IF(mql.is_closed) AS closed_deals,
    DIV0(COUNT_IF(mql.is_closed), COUNT(*)) AS conversion_rate,
    AVG(mql.days_to_close) AS avg_days_to_close,
    COUNT_IF(sales.seller_id IS NOT NULL) AS acquired_sellers_with_sales,
    COALESCE(SUM(sales.orders), 0) AS acquired_seller_orders,
    COALESCE(SUM(sales.gmv_brl), 0) AS acquired_seller_gmv_brl
FROM {{ ref('dim_marketing_lead') }} AS mql
LEFT JOIN seller_sales AS sales
    ON mql.seller_id = sales.seller_id
GROUP BY mql.first_contact_month, mql.origin
