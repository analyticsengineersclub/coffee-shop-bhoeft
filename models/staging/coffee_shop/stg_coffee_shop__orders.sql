with source as(

    select * from {{ source('coffee_shop', 'orders') }}
    
)

, renamed as(

    select
        id as order_id,
        created_at as ordered_at,
        customer_id,
        total,
        address,
        state,
        zip
    from source

)

select * from renamed