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
        {{ dbt_utils.generate_surrogate_key(['od.id_pedido', 'od.id_pedido']) }} as id_venda,
        od.id_pedido,
        o.id_cliente,
        o.id_colaborador,
        od.id_produto,
        o.id_transportadora,
        
        -- Datas, tempos e status relacionados à venda
        o.data_pedido,
        o.data_requisicao,
        o.data_embarque,
        o.dias_processamento,
        o.status_embarque,
        o.pedido_atrasado,
        
        -- Métricas de Venda
        od.preco_unitario,
        od.quantidade,
        cast(od.quantidade * od.preco_unitario as numeric) as preco_total_sem_desconto,
        od.desconto,

        od.preco_total as preco_total_com_desconto
        

    from order_details od
    left join orders o on od.id_pedido = o.id_pedido
)

select * from vendas