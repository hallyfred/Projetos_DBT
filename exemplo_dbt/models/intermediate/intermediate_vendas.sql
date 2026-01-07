{{ config(materialized='ephemeral') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_details as (
    select * from {{ ref('stg_order_details') }}
),

vendas as (
    select
        -- Criando uma chave composta e única para cada linha da fato
        -- Lembrete: a tabela order_details não possui uma chave primária única
        {{ dbt_utils.generate_surrogate_key(['od.order_id', 'od.product_id']) }} as sales_id,
        od.order_id,
        o.customer_id,
        o.employee_id,
        od.product_id,
        
        -- Datas
        o.order_date,
        
        -- Métricas de Venda
        od.unit_price,
        od.quantity,
        od.discount,
        
        -- Cálculos de Receita
        cast(od.unit_price * od.quantity as numeric) as gross_revenue,
        cast((od.unit_price * od.quantity) * (1 - od.discount) as numeric) as net_revenue
    from order_details od
    left join orders o on od.order_id = o.order_id
)

select * from vendas