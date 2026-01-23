{{ config(
    materialized='table',
    schema='marts'
) }}

with vendas as (

    select
       *
    from {{ ref('intermediate_vendas_agrupado') }}

)

select * from vendas