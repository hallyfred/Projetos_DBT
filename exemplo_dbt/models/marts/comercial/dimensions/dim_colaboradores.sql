{{ config(
    materialized='table',
    schema='marts'
) }}

with colaboradores as (

    select
       *
    from {{ ref('intermediate_colaboradores') }}
)

select * from colaboradores