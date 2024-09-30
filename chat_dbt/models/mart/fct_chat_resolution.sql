{{
    config(materialized="view")
}}

with joined_cte as (
    select 
        chats.*,
        cat.parent_id
    from {{ ref('dim_chats') }} chats
    inner join {{ ref('dim_categories') }} cat
        on chats.chat_category_id = cat.id
        and cat.disabled = 'TRUE'
)
select 
    chat_category_id,
    (sum(chat_resolved_flag) * 100.0 / count(*)) as resolution_rate,
    avg(resolution_time_seconds) / 60.0 AS avg_resolution_time_minutes

from joined_cte
group by 1