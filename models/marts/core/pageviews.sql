with loggedin_pageviews as(

    select 
        pageview_id,
        customer_id,
        visitor_id, 
        device_type,
        viewed_at,
        page,
        row_number() over (partition by customer_id order by viewed_at asc) as visit_number
    from {{ ref('stg_web_tracking__pageviews') }}
    where customer_id is not null

)

, stitched_visitor as(

    select
        customer_id,
        visitor_id as stitched_visitor_id
    from loggedin_pageviews
    where visit_number = 1

)

, stitched_pageviews as(

    select 
        lp.pageview_id,
        lp.customer_id,
        stitched_visitor.stitched_visitor_id as visitor_id,
        lp.device_type,
        lp.viewed_at,
        lp.page
    from loggedin_pageviews lp
    left join stitched_visitor on lp.customer_id = stitched_visitor.customer_id

)

, unknown_pageviews as(
        
    select
        pageview_id,
        customer_id,
        visitor_id, 
        device_type,
        viewed_at,
        page
    from {{ ref('stg_web_tracking__pageviews') }}
    where customer_id is null

)

, recombined as(

    select * from stitched_pageviews

    union distinct

    select * from unknown_pageviews

)

select * 
from recombined