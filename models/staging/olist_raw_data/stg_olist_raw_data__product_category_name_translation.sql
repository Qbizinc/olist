with 

source as (

    select * from {{ source('olist_raw_data', 'product_category_name_translation') }}

),

renamed as (

    select
        c1,
        c2

    from source

)

select * from renamed
