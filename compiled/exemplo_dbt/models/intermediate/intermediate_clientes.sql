

with  __dbt__cte__intermediate_vendas_agrupado as (


with orders as (
    select * from `projetodbt-479518`.`dbt_staging`.`stg_orders`
),

order_details as (
    select * from `projetodbt-479518`.`dbt_staging`.`stg_order_details`
),

vendas_agregadas as (
    select 
        od.ID_PEDIDO,
        sum(QUANTIDADE) as QUANTIDADE_TOTAL,
        sum(DESCONTO) as DESCONTO_TOTAL,
        sum(PRECO_UNITARIO * QUANTIDADE) as RECEITA_BRUTA_TOTAL,
        sum(PRECO_TOTAL) as RECEITA_TOTAL_COM_DESCONTO

    from order_details od
    group by od.ID_PEDIDO),

vendas_completas as (
    select
        o.ID_PEDIDO,
        o.ID_CLIENTE,
        o.ID_COLABORADOR,
        o.ID_TRANSPORTADORA,
        o.DATA_PEDIDO,
        o.DATA_REQUISICAO,
        o.DATA_EMBARQUE,
        o.STATUS_EMBARQUE,
        o.PEDIDO_ATRASADO,
        va.QUANTIDADE_TOTAL,
        va.RECEITA_BRUTA_TOTAL,
        va.DESCONTO_TOTAL,
        va.RECEITA_TOTAL_COM_DESCONTO,
        o.VALOR_FRETE,

        from orders o
    left join vendas_agregadas va
        on o.ID_PEDIDO = va.ID_PEDIDO)

select * from vendas_completas
), clientes as (
    select * from `projetodbt-479518`.`dbt_staging`.`stg_costumers`
),

intermediate_clientes as (
    select ID_CLIENTE,
        min(DATA_PEDIDO) as PRIMEIRA_COMPRA,
        max(DATA_PEDIDO) as ULTIMA_COMPRA,
        count(distinct ID_PEDIDO) as TOTAL_PEDIDOS,
        sum(RECEITA_TOTAL_COM_DESCONTO) as VALOR_TOTAL_GASTO
    from __dbt__cte__intermediate_vendas_agrupado 
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