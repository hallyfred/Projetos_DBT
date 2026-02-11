{{ config(
    materialized='table',
    schema='marts'
) }}

with fornecedores as (

    select
       *
    from {{ ref('intermediate_fornecedores') }}
)

select * from fornecedores