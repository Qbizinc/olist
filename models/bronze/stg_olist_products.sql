-- models/bronze/stg_olist_products.sql

-- TODO: Remove the translation join here, and move it to the silver layer, allowing for expansion for other trranslation files

SELECT
    p.product_id,
    p.product_category_name,
    COALESCE(t.c2, p.product_category_name) AS product_category_name_english, -- Handle missing translations
    p.product_name_lenght AS product_name_length, -- Typo in source data
    p.product_description_lenght AS product_description_length, -- Typo in source data
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM {{ source('olist_raw_data', 'products') }} p
LEFT JOIN {{ source('olist_raw_data', 'product_category_name_translation') }} t
    ON p.product_category_name = t.c1