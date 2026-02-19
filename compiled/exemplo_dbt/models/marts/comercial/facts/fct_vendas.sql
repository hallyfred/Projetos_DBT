

with  __dbt__cte__intermediate_vendas as (


with orders as (
    select * from `projetodbt-479518`.`dbt_staging`.`stg_orders`
),

order_details as (
    select * from `projetodbt-479518`.`dbt_staging`.`stg_order_details`
),

vendas as (
    select
        -- Criando uma chave composta e única para cada linha da fato
        -- Lembrete: a tabela order_details não possui uma chave primária única
        to_hex(md5(cast(coalesce(cast(od.ID_PEDIDO as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(od.ID_PRODUTO as string), '_dbt_utils_surrogate_key_null_') as string))) as ID_VENDAS,
        od.ID_PEDIDO,
        o.ID_CLIENTE,
        o.ID_COLABORADOR,
        od.ID_PRODUTO,
        o.ID_TRANSPORTADORA,
        -- Datas, tempos e status relacionados à venda
        o.DATA_PEDIDO,
        o.DATA_REQUISICAO,
        o.DATA_EMBARQUE,
        o.DIAS_PROCESSAMENTO,
        o.STATUS_EMBARQUE,
        o.PEDIDO_ATRASADO,
        
        -- Métricas de Venda
        od.PRECO_UNITARIO,
        od.QUANTIDADE,
        cast(od.QUANTIDADE * od.PRECO_UNITARIO as numeric) as PRECO_TOTAL_SEM_DESCONTO,
        od.DESCONTO,

        od.PRECO_TOTAL as PRECO_TOTAL_COM_DESCONTO
        

    from order_details od
    left join orders o on od.ID_PEDIDO = o.ID_PEDIDO
)

select * from vendas
), vendas as (

    select
       *
    from __dbt__cte__intermediate_vendas

)

select * from vendas