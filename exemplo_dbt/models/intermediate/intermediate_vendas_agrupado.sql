{{ config(materialized='ephemeral') }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_details as (
    select * from {{ ref('stg_order_details') }}
),

vendas_agregadas as (
    select 
        od.id_pedido,
        sum(quantidade) as quantidade_total,
        sum(desconto) as desconto_total,
        sum(preco_unitario * quantidade) as receita_bruta_total,
        sum(preco_total) as receita_total_com_desconto

    from order_details od
    group by od.id_pedido),

vendas_completas as (
    select
        o.id_pedido,
        o.id_cliente,
        o.id_colaborador,
        o.id_transportadora,
        o.data_pedido,
        o.data_requisicao,
        o.data_embarque,
        o.status_embarque,
        o.pedido_atrasado,
        va.quantidade_total,
        va.receita_bruta_total,
        va.desconto_total,
        va.receita_total_com_desconto,
        o.valor_frete,
        
        from orders o
    left join vendas_agregadas va
        on o.id_pedido = va.id_pedido)


select * from vendas_completas