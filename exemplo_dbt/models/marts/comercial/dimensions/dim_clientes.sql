{{ config(
    materialized='table',
    schema='marts'
) }}

with clientes_completo as (

    select
       *
    from {{ ref('intermediate_clientes') }}
)

select * from clientes_completo