{{ config(
    materialized='ephemeral',
    tags=['intermediate']
) }}

with orders as (

    select
        extract(year from order_date) as order_year,
        extract(month from order_date) as order_month,
        freight as total_frete  -- Ajustei o nome para bater com a soma abaixo
    from {{ ref('stg_orders') }}

),

vendas_agrupadas as (

    select
        order_year,
        order_month,
        sum(total_frete) as soma_frete
    from orders
    group by order_year, order_month

)
        
select * from vendas_agrupadas