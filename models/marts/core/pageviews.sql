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

-- solves AEC Week 4: Exercise 1
, user_stitching as(

    select * from stitched_pageviews

    union distinct

    select * from unknown_pageviews

)

/* solves AEC week 4: Exercise 2 (all CTEs here until end)
   Modeling Decision: include both exercises into a single model */
, per_visitor_pageview_viewed_at_lag1 as (

select
    pageview_id,
    customer_id,
    visitor_id,
    device_type,
    page,
    viewed_at,
    lag(viewed_at, 1, null) over(partition by customer_id, visitor_id order by viewed_at asc) viewed_at_lag1
from user_stitching
)


, per_visitor_pageview_minutes_diff_prior as(

select *,
    timestamp_diff(viewed_at, viewed_at_lag1, minute) as minutes_diff_from_prior_view
from per_visitor_pageview_viewed_at_lag1

)


, per_visitor_identify_new_session as(

select *,
    case 
        when minutes_diff_from_prior_view is null then 1
        when minutes_diff_from_prior_view <= 30 then 0
        else 1
    end as is_new_session
from per_visitor_pageview_minutes_diff_prior

)


, sessionized_pageviews as(

select
    pageview_id,
    customer_id,
    visitor_id,
    device_type,
    viewed_at,
    page,
    viewed_at_lag1,
    minutes_diff_from_prior_view,
    is_new_session,
    sum(is_new_session) over(partition by customer_id, visitor_id order by viewed_at asc) as session_id
from per_visitor_identify_new_session

)

select *
from sessionized_pageviews


