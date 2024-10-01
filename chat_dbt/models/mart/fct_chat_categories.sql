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
    count(*) as count_of_chats

from joined_cte
group by 1  