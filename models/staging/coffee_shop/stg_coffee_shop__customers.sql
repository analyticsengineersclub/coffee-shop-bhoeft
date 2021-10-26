
with source as(
    -- creates DAG dependency b/w source and this stg model for docs!
    select * from {{ source('coffee_shop', 'customers') }}
)

, renamed as(
    from 
        id as customer_id, 
        name, 
        email
    from source
)

select * from renamed
