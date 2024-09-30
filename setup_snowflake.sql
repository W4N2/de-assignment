use role accountadmin;
create warehouse dbt_wh with warehouse_size='x-small';
create database if not exists chat_db;
create role if not exists dbt_sa_role;
show grants on warehouse dbt_wh;

grant usage on warehouse dbt_wh to role dbt_sa_role;
grant role dbt_sa_role to user W4N2;

grant all on database chat_db to role dbt_sa_role;

use role dbt_sa_role;

create schema chat_db.chat_raw;
create schema chat_db.chat_int;