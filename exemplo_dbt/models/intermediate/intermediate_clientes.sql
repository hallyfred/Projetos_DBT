{{ config(materialized='ephemeral') }}

with clientes as (
    select * from {{ ref('stg_costumers') }}
),

intermediate_clientes as (
    select ID_CLIENTE,
        min(DATA_PEDIDO) as PRIMEIRA_COMPRA,
        max(DATA_PEDIDO) as ULTIMA_COMPRA,
        count(distinct ID_PEDIDO) as TOTAL_PEDIDOS,
        sum(RECEITA_TOTAL_COM_DESCONTO) as VALOR_TOTAL_GASTO
    from {{ ref('intermediate_vendas_agrupado') }} 
    group by ID_CLIENTE
),

clientes_completo as (
    select 
    c.*,
    ic.PRIMEIRA_COMPRA,
    ic.ULTIMA_COMPRA,
    coalesce(ic.TOTAL_PEDIDOS, 0) as TOTAL_PEDIDOS,
    coalesce(ic.VALOR_TOTAL_GASTO, 0) as VALOR_TOTAL_GASTO,
    ntile(4) over (order by coalesce(ic.VALOR_TOTAL_GASTO, 0) asc) as CLASSE_CLIENTE


from clientes c
left join intermediate_clientes ic
    on c.ID_CLIENTE = ic.ID_CLIENTE
)

select *,

case
    when CLASSE_CLIENTE = 4 then 'VIP'
    when CLASSE_CLIENTE = 3 then 'Ouro'
    when CLASSE_CLIENTE = 2 then 'Prata'
    when CLASSE_CLIENTE = 1 then 'Bronze'
    else 'Sem Classe' end as CLASSIFICACAO_CLIENTE

 from clientes_completo
