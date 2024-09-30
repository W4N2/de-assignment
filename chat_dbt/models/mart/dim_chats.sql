{{
    config(materialized="incremental")
}}

select * from {{ ref("stg_chats") }}
{% if is_incremental() %}
    -- Incremental logic will manage checksum and insert new/changed records only.
    where row_hash not in (select row_hash from {{ this }} )
{% endif %}