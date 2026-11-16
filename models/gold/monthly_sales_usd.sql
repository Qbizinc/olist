-- models/gold/monthly_sales_usd.sql
-- Monthly item sales by product category in BRL and USD, each item converted at the BRL->USD
-- rate of its purchase date. Item grain from staging: PRICE_BRL totals about 13.59M, while
-- MONTHLY_SALES_BY_PRODUCT_CATEGORY.PRICE_SUM shows 14.12M because FCT_ORDER_ITEMS repeats
-- items per payment.
SELECT
    DATE_TRUNC('MONTH', orders.order_purchase_timestamp)::DATE AS order_purchase_month,
    products.product_category_name_english AS product_category,
    COUNT(DISTINCT items.order_id) AS orders,
    COUNT(*) AS items,
    SUM(items.price) AS price_brl,
    SUM(items.freight_value) AS freight_brl,
    SUM(items.price * fx.usd_per_brl) AS price_usd,
    SUM(items.freight_value * fx.usd_per_brl) AS freight_usd,
    DIV0(SUM(items.price * fx.usd_per_brl), SUM(items.price)) AS avg_usd_per_brl
FROM {{ ref('stg_olist_order_items') }} AS items
INNER JOIN {{ ref('stg_olist_orders') }} AS orders
    ON items.order_id = orders.order_id
LEFT JOIN {{ ref('stg_olist_products') }} AS products
    ON items.product_id = products.product_id
LEFT JOIN {{ ref('fct_fx_rate_daily') }} AS fx
    ON orders.order_purchase_timestamp::DATE = fx.rate_date
GROUP BY 1, 2
