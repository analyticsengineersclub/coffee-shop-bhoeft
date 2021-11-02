with source as(

    -- creates DAG dependency b/w source and this stg model for docs!
    select * from {{ source('coffee_shop', 'customers') }}

)

, renamed as(

    select 
        id as customer_id, 
        name as customer_name, 
        email as customer_email
    from source

)

select * from renamed
