SELECT 
"dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_ID" AS "person_id",
"dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_ZIP_CODE_PREFIX" AS "zip_code_prefix",
'customer' AS person_type
FROM {{ref('stg_olist_customers')}} AS "dbt_jeck_bronze__stg_olist_customers"
UNION ALL 
SELECT "dbt_jeck_bronze__stg_olist_sellers"."SELLER_ID" AS "person_id", 
"dbt_jeck_bronze__stg_olist_sellers"."SELLER_ZIP_CODE_PREFIX" AS "zip_code_prefix", 
'seller' AS person_type 
FROM {{ref('stg_olist_sellers')}} AS "dbt_jeck_bronze__stg_olist_sellers"
