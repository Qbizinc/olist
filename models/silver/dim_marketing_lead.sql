-- models/silver/dim_marketing_lead.sql
-- One row per marketing qualified lead, with its closed deal when there is one.
SELECT
    mql.mql_id,
    mql.first_contact_date,
    DATE_TRUNC('MONTH', mql.first_contact_date) AS first_contact_month,
    mql.landing_page_id,
    mql.origin,
    deal.mql_id IS NOT NULL AS is_closed,
    deal.seller_id,
    deal.won_date,
    DATEDIFF('day', mql.first_contact_date, deal.won_date) AS days_to_close,
    deal.business_segment,
    deal.lead_type,
    deal.lead_behaviour_profile,
    deal.business_type,
    deal.has_company,
    deal.has_gtin,
    deal.declared_monthly_revenue
FROM {{ ref('stg_olist_marketing_qualified_leads') }} AS mql
LEFT JOIN {{ ref('stg_olist_closed_deals') }} AS deal
    ON mql.mql_id = deal.mql_id
