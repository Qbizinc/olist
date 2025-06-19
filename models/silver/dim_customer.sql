SELECT "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_ID",
    "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_UNIQUE_ID",
    "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_CITY",
    "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_STATE",
    CONCAT("dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_CITY", ', ', "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_STATE") AS "CUSTOMER_CITY_STATE",
    "dbt_jeck_bronze__stg_olist_geolocation"."GEOLOCATION_LAT",
    "dbt_jeck_bronze__stg_olist_geolocation"."GEOLOCATION_LNG"
FROM {{ref('stg_olist_customers')}} AS "dbt_jeck_bronze__stg_olist_customers"
    LEFT JOIN {{ref('stg_olist_geolocation')}} AS "dbt_jeck_bronze__stg_olist_geolocation" ON "dbt_jeck_bronze__stg_olist_customers"."CUSTOMER_ZIP_CODE_PREFIX" = "dbt_jeck_bronze__stg_olist_geolocation"."GEOLOCATION_ZIP_CODE_PREFIX"
GROUP BY 3, 5, 1, 4, 2, 6, 7
