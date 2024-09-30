
{{ config(materialized="view") }}

with staging as (
    select * from {{ source('chat_raw', 'chats_raw') }}
)
select 
    cast(ID as varchar) as id,
    cast(CHAT_CATEGORY_ID as varchar) as chat_category_id,
    cast(CREATED_AT as timestamp) as created_at,
    cast(IS_CUSTOMER_INITIATED as boolean) as is_customer_initiated,
    cast(RESOLVED_AT as varchar) as resolved_at
from staging 