

with produtos as (
    select * from `projetodbt-479518`.`dbt_staging`.`stg_products`
),

 -- Detalhes dos pedidos para calcular métricas de vendas por produto
detalhes_pedidos as ( 
    select * from `projetodbt-479518`.`dbt_staging`.`stg_order_details`
),

-- Cálculo das métricas de vendas por produto
metricas_produtos as (
    select
    ID_PRODUTO,
    count(distinct ID_PEDIDO) as FREQUENCIA_VENDAS,
    sum(QUANTIDADE) as QUANTIDADE_VENDIDA,
    sum(PRECO_TOTAL) as RECEITA_TOTAL
    from detalhes_pedidos  
    group by ID_PRODUTO
 ),

 -- Agregação final para unir produtos com suas métricas de vendas
 pedidos_agrupados as (
    select 
    p.ID_PRODUTO,
    p.NOME_PRODUTO,
    p.ID_CATEGORIA,
    p.UNIDADES_EM_ESTOQUE,
    p.STATUS_ESTOQUE,
    coalesce(mp.RECEITA_TOTAL, 0) as RECEITA_TOTAL,
    coalesce(mp.FREQUENCIA_VENDAS, 0) as FREQUENCIA_VENDAS,
    coalesce(mp.QUANTIDADE_VENDIDA, 0) as QUANTIDADE_VENDIDA,
    sum(coalesce(mp.RECEITA_TOTAL, 0)) OVER (Order by coalesce(mp.RECEITA_TOTAL, 0) desc) as RECEITA_TOTAL_ACUMULADA,
    sum(coalesce(mp.RECEITA_TOTAL, 0)) OVER () as RECEITA_TOTAL_GERAL

    from produtos p
    left join metricas_produtos mp
        on p.ID_PRODUTO = mp.ID_PRODUTO
 ),

 -- Classificação ABC dos produtos com base na receita acumulada
 produtos_completos as (
    select *,

   safe_divide(RECEITA_TOTAL_ACUMULADA, RECEITA_TOTAL_GERAL) as PERCENTUAL_RECEITA_ACUMULADA,
    case 
          when safe_divide(RECEITA_TOTAL_ACUMULADA, RECEITA_TOTAL_GERAL) <= 0.8 then 'A'
          when safe_divide(RECEITA_TOTAL_ACUMULADA, RECEITA_TOTAL_GERAL) <= 0.95 then 'B'
          else 'C' 
    end as CURVA_ABC

    from pedidos_agrupados

 )    
 
    select * from produtos_completos