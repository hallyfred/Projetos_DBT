{{ config(
    materialized='table',
    schema='marts'
) }}

with source as (
    select * from {{ ref('intermediate_produtos') }}
)

select * from source