-- One row per (first_contact_month, origin).
SELECT first_contact_month, origin, COUNT(*) AS n
FROM {{ ref('seller_acquisition_funnel') }}
GROUP BY first_contact_month, origin
HAVING COUNT(*) > 1
