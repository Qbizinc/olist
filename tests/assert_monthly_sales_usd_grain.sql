-- One row per (order_purchase_month, product_category).
SELECT order_purchase_month, product_category, COUNT(*) AS n
FROM {{ ref('monthly_sales_usd') }}
GROUP BY order_purchase_month, product_category
HAVING COUNT(*) > 1
