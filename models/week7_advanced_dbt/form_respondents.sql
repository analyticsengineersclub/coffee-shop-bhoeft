{{ config(
    materialized='incremental',
    unique_key='github_username'
) }}

with source as (
    
    select * 
    from {{ source('advanced_dbt_examples', 'form_events') }}
    -- What does is_incremental() do? Checks 4 things.
        -- 1. Does this model already exist as an object in the database?
        -- 2. Is that database object a table?
        -- 3. Is this model configured with `materialized = 'incremental'`?
        -- 4. Was the `--full-refresh` flag passed to this `dbt run`? (More on this to come later)
        -- Yes Yes Yes No == an incremental run, else it creates or replace table run.
    {% if is_incremental() %}
    where timestamp > (select max(last_form_entry) from {{ this }})
    {% endif %}
)

, aggregated as (
    
    select
        github_username,
        min(timestamp) as first_form_entry,
        max(timestamp) as last_form_entry,
        count(*) as number_of_entries
    from source
    group by 1

)

select * from aggregated