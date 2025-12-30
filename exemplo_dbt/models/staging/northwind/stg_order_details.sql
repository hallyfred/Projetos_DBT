{{ config(materialized='table') }}
with source as (
    select * from {{ source('northwind', 'order_details') }}
),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(order_id as int64) as id_pedido,
        cast(product_id as int64) as id_produto,

        -- transformações de valores monetários (Casting para NUMERIC)
        cast(unit_price as numeric) as preco_unitario,
        cast(quantity as int64) as quantidade,
        cast(discount as numeric) as desconto,

        -- Engenharia de variáveis (adicionando novas colunas para enriquecimento de dados)

        -- Cálculo do preço total do item considerando quantidade e desconto
        cast((unit_price * quantity * (1 - discount)) as numeric) as preco_total

    from source
)

select * from renamed