SELECT "dbt_jeck_bronze__stg_olist_sellers"."SELLER_ID",
    "dbt_jeck_bronze__stg_olist_sellers"."SELLER_ZIP_CODE_PREFIX",
    CASE
        WHEN LENGTH(CAST("dbt_jeck_bronze__stg_olist_sellers"."SELLER_ZIP_CODE_PREFIX" AS VARCHAR)) = 4 THEN CONCAT('0', COALESCE(CAST("dbt_jeck_bronze__stg_olist_sellers"."SELLER_ZIP_CODE_PREFIX" AS VARCHAR), ''))
        ELSE CAST("dbt_jeck_bronze__stg_olist_sellers"."SELLER_ZIP_CODE_PREFIX" AS VARCHAR)
    END AS "SELLER_ZIP_CODE_FIXED",
    "dbt_jeck_bronze__stg_olist_sellers"."SELLER_CITY",
    "dbt_jeck_bronze__stg_olist_sellers"."SELLER_STATE",
    CONCAT(COALESCE(CONCAT(COALESCE("dbt_jeck_bronze__stg_olist_sellers"."SELLER_CITY", ''), ', '), ''), COALESCE("dbt_jeck_bronze__stg_olist_sellers"."SELLER_STATE", '')) AS "SELLER_CITY_STATE",
    "dbt_jeck_bronze__stg_olist_geolocation"."GEOLOCATION_LAT",
    "dbt_jeck_bronze__stg_olist_geolocation"."GEOLOCATION_LNG"
FROM {{ref('stg_olist_sellers')}} AS "dbt_jeck_bronze__stg_olist_sellers"
    LEFT JOIN {{ref('stg_olist_geolocation')}} AS "dbt_jeck_bronze__stg_olist_geolocation" ON "dbt_jeck_bronze__stg_olist_sellers"."SELLER_ZIP_CODE_PREFIX" = "dbt_jeck_bronze__stg_olist_geolocation"."GEOLOCATION_ZIP_CODE_PREFIX"
GROUP BY 7, 8, 4, 6, 1, 5, 3, 2
