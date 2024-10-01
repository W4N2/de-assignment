{{
    config(materialized="view")
}}

with q1 as (
    select
    'The date that saw the lowest number of chats resolved' as question,
    created_at_date_mel as answer 
    from 
    (
        select 
        created_at_date_mel,
        from {{ ref('fct_chats_per_day') }}
        where 
        sum_resolved_chats = (
            SELECT min(sum_resolved_chats)
            FROM {{ ref('fct_chats_per_day') }}
        )
    )
),
q2 as (
    select
    'The date that saw the highest number of chats resolved' as question,
    created_at_date_mel as answer 
    from 
    (
        select 
        created_at_date_mel,
        from {{ ref('fct_chats_per_day') }}
        where 
        sum_resolved_chats = (
            SELECT max(sum_resolved_chats)
            FROM {{ ref('fct_chats_per_day') }}
        )
    )
),
q3 as (
    select
    'The median number customer-initiated chats which are resolved per day' as question,
    median_num_chats_resolved as answer 
    from 
    (
        select 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_resolved_chats) as median_num_chats_resolved,
        from {{ ref('fct_chats_per_day') }}
       
    )
),
q4 as (
    select
    'The ten most populous categories for chats created by customers' as question,
    categories as answer 
    from 
    (
        select listagg(chat_category_id, ', ') within group (order by count_of_chats desc) as categories
        from {{ ref('fct_chat_categories') }}
        limit 10
    )
),
q5 as (
    select
    'The ten categories with the lowest resolution rate' as question,
    categories as answer 
    from 
    (
        select listagg(chat_category_id, ', ') within group (order by resolution_rate asc) as categories
        from {{ ref('fct_chat_resolution') }}
        limit 10
    )
),
q6 as (
    select
    'The ten categories with the fastest resolution time' as question,
    categories as answer 
    from 
    (
        select listagg(chat_category_id, ', ') within group (order by avg_resolution_time_minutes asc) as categories
        from {{ ref('fct_chat_resolution') }}
        limit 10
    )
)

select question, cast(answer as string) as answer from q1
union all
select question, cast(answer as string) as answer from q2
union all
select question, cast(answer as string) as answer from q3
union all
select question, cast(answer as string) as answer from q4
union all
select question, cast(answer as string) as answer from q5
union all
select question, cast(answer as string) as answer from q6
union all
select 'The hourly distribution of chats by time-of-day and day-of-week' as question, 'select * from fct_chats_per_day_hour' as answer