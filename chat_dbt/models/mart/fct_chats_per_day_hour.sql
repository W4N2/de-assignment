{{
    config(materialized="view")
}}

select 
    dayname(created_at_dttm_mel) as created_at_dayname_mel,
    date_part('hour', created_at_dttm_mel) as created_at_hour_mel,
    count(id) as count_of_chats
from {{ ref('dim_chats') }}
group by 1,2