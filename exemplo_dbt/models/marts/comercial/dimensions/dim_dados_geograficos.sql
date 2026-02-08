{{ config(
    materialized='table',
    schema='marts'
) }}

with dados_geograficos as (

    select
       *
    from {{ ref('intermediate_dados_geograficos') }}
)

select * from dados_geograficos