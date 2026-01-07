{{ config(materialized='table') }}

with source as (
    select * from {{ source('northwind', 'products') }}
),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(product_id as int64) as id_produto,
        cast(supplier_id as int64) as id_fornecedor,
        cast(category_id as int64) as id_categoria,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(product_name) as nome_produto,

        -- Lembrete: quantity_per_unit pode conter valores como "24 - 12 oz bottles"
        {{clean_string('quantity_per_unit')}} as quantidade_por_unidade,

        cast(units_in_stock as int64) as unidades_em_estoque,
        cast(units_on_order as int64) as unidades_por_pacote,
        cast(reorder_level as int64) as nivel_de_reposicao,

        -- transformações de valores monetários (Casting para NUMERIC)
        cast(unit_price as numeric) as preco_unitario,

        -- transformação de booleanos (Casting para BOOLEAN)
        case when discontinued = 1 then 'SIM' else 'NAO' end as descontinuado,

        -- Engenharia de variáveis (adicionando novas colunas para enriquecimento de dados)
        cast((unit_price * units_in_stock) as numeric) as valor_estoque,

        -- Status do estoque: Esgotado, Estoque Baixo ou Estoque Normal
        case 
            when units_in_stock = 0 then 'ESGOTADO'
            when units_in_stock < reorder_level then 'ESTOQUE BAIXO'
            else 'ESTOQUE NORMAL'
        end as status_estoque,
        
        -- Necessidade de Reposição: Sim ou Não
        case 
            when units_in_stock <= reorder_level and discontinued = 0 then "SIM" 
            else "NAO" 
        end as necessario_repor

    from source
)

select * from renamed