
    
    



with __dbt__cte__intermediate_vendas_agrupado as (


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
) select ID_PEDIDO
from __dbt__cte__intermediate_vendas_agrupado
where ID_PEDIDO is null


