{{ config(
    materialized='table',
    schema='marts'
) }}

with vendas as (

    select
       *
    from {{ ref('intermediate_vendas') }}

)

select * from vendas