
-- alternatively, could use dbt's date_utils package for date_spine()
-- here, a dimension dates (different date format varieties) is built from unique order and pageview dates

with deduplicated_days as(

    select 
        distinct date_trunc(ordered_at, day) as date_day 
    from {{ ref('stg_coffee_shop__orders') }}

    union distinct 

    select 
        distinct date_trunc(viewed_at, day) as date_day 
    from {{ ref('stg_web_tracking__pageviews') }}

)

 , dim_dates as(

    select 
        date_day,
        date_trunc(date_day, week) as date_week,
        date_trunc(date_day, month) as date_month,
        date_trunc(date_day, year) as date_year
    from deduplicated_days

)

select *
from dim_dates
order by date_day