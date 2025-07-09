SELECT "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_ID" AS "person_id",
'customer' AS person_type
FROM {{ref('stg_olist_customers')}} AS "dbt_jeck_bronze__stg_olist_customers"
GROUP BY 1
UNION ALL 
SELECT "dbt_jeck_bronze__stg_olist_sellers"."SELLER_ID" AS "person_id", 
'seller' AS person_type 
FROM {{ref('stg_olist_sellers')}} AS "dbt_jeck_bronze__stg_olist_sellers"
GROUP BY 1