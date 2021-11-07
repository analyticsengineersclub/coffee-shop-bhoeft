with stg_products as (

    select * from {{ ref('stg_coffee_shop__products') }}

)

, stg_product_prices as (

    select * from {{ ref('stg_coffee_shop__product_prices') }}

)

, combined as (

    select 
        p.product_id,
        p.product_name,
        p.product_category,
        pp.product_price,
        pp.price_created_at,
        pp.price_ended_at
    from stg_products p
    inner join stg_product_prices pp on p.product_id = pp.product_id

)

select *
from combined
