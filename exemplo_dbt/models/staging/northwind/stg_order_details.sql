{{ config(materialized='table') }}
with source as (
    select * from {{ source('northwind', 'order_details') }}
),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(order_id as int64) as ID_PEDIDO,
        cast(product_id as int64) as ID_PRODUTO,

        -- transformações de valores monetários (Casting para NUMERIC)
        cast(unit_price as numeric) as PRECO_UNITARIO,
        cast(quantity as int64) as QUANTIDADE,
        cast(discount as numeric) as DESCONTO,

        -- Engenharia de variáveis (adicionando novas colunas para enriquecimento de dados)

        -- Cálculo do preço total do item considerando quantidade e desconto
        cast((unit_price * quantity * (1 - discount)) as numeric) as PRECO_TOTAL

    from source
)

select * from renamed