
{{ config(materialized="view") }}

with staging as (
    select * from {{ source('chat_raw', 'categories_raw') }}
)
select 
    cast(ID as varchar) as id,
    cast(PARENT_ID as varchar) as parent_id,
    cast(DISABLED as boolean) as disabled

from staging 