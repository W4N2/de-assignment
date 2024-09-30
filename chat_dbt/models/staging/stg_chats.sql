
{{ config(materialized="view") }}

with staging as (
    select * from {{ source('chat_raw', 'chats_raw') }}
)
select 
    cast(ID as varchar) as id,
    cast(CHAT_CATEGORY_ID as varchar) as chat_category_id,
    to_timestamp_tz(CREATED_AT, 'YYYY-MM-DD HH24:MI:SS.FF6 UTC') as created_at,
    cast(IS_CUSTOMER_INITIATED as boolean) as is_customer_initiated,
    to_timestamp_tz(RESOLVED_AT, 'YYYY-MM-DD HH24:MI:SS.FF6 UTC') as resolved_at,
    hash(concat(id, created_at)) as row_hash
from staging 