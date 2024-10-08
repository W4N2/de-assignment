{{
    config(materialized="view")
}}

select 
    to_date(created_at_dttm_mel) as created_at_date_mel,
    dayname(created_at_dttm_mel) as created_at_dayname_mel,
    count(id) as count_of_chats,
    sum(chat_resolved_flag) as sum_resolved_chats
from {{ ref('dim_chats') }}
group by 1,2