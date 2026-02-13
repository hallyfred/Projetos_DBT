{{ config(
    materialized='table',
    schema='marts'
) }}

with transportadoras as (

    select
       *
    from {{ ref('intermediate_shippers') }}
)

select * from transportadoras