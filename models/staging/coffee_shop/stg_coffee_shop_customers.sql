
with source as(
    -- creates DAG dependency b/w source and this stg model for docs!
    select * from {{ source('coffee_shop', 'customers') }}
)

, renamed as(
    SELECT 
        id as customer_id, 
        name, 
        email
    FROM source
)

select * from renamed
