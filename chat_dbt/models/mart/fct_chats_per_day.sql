{{
    config(materialized="view")
}}

select 
    to_date(CREATED_AT) as created_at_date,
    dayname(CREATED_AT) as created_at_dayname,
    count(id) as count_of_chats
from {{ ref('dim_chats') }}
group by 1,2