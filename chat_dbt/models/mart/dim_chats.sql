{{
    config(materialized="incremental")
}}

select 
    *,
    convert_timezone('Australia/Melbourne', created_at) as created_at_dttm_mel,
    convert_timezone('Australia/Melbourne', resolved_at) as resolved_at_dttm_mel,
    case 
        when resolved_at is not null 
            then 1 
            else 0 
    end as chat_resolved_flag,
    case 
        when resolved_at is not null 
            then datediff('second', created_at, resolved_at)
            else null
    end as resolution_time_seconds
from {{ ref("stg_chats") }}

{% if is_incremental() %}
    -- Incremental logic will manage checksum and insert new/changed records only.
    where row_hash not in (select row_hash from {{ this }} )
{% endif %}