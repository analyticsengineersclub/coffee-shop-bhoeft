with source as(
    select * from {{ source('coffee_shop', 'orders') }}
)

, renamed as(
    select
        id as order_id,
        create_at,
        customer_id,
        total as total_in_dollars,
        address,
        state,
        zip
    from source
)

select * from renamed