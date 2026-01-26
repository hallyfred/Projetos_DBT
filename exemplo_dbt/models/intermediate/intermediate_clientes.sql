{{ config(materialized='ephemeral') }}

with orders as (
    select * from {{ ref('stg_costumers') }}
),

intermediate_clientes as (
    select id_cliente,
        min(data_pedido) as PRIMEIRA_COMPRA,
        max(data_pedido) as ULTIMA_COMPRA,
        count(distinct id_pedido) as TOTAL_PEDIDOS,
        sum(receita_total_com_desconto) as VALOR_TOTAL_GASTO
    from {{ ref('intermediate_vendas_agrupado') }} 
    group by id_cliente
),

clientes_completo as (
    select 
    c.*,
    ic.PRIMEIRA_COMPRA,
    ic.ULTIMA_COMPRA,
    coalesce(ic.TOTAL_PEDIDOS, 0) as TOTAL_PEDIDOS,
    coalesce(ic.VALOR_TOTAL_GASTO, 0) as VALOR_TOTAL_GASTO,
    ntile(4) over (order by coalesce(ic.VALOR_TOTAL_GASTO, 0) asc) as CLASSE_CLIENTE


from orders c
left join intermediate_clientes ic
    on c.id_cliente = ic.id_cliente
)

select *,

case
    when CLASSE_CLIENTE = 4 then 'VIP'
    when CLASSE_CLIENTE = 3 then 'Ouro'
    when CLASSE_CLIENTE = 2 then 'Prata'
    when CLASSE_CLIENTE = 1 then 'Bronze'
    else 'Sem Classe' end as CLASSIFICACAO_CLIENTE

 from clientes_completo
