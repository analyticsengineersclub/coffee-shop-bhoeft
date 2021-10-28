with source as(
    
    select * from {{ source('coffee_shop', 'product_prices') }}

)

, renamed as(

    select 
        id as product_price_id,
        product_id,
        price as product_price,
        created_at as price_created_at,
        ended_at as price_ended_at
    from source

)

select * from renamed
