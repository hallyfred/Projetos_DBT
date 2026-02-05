{{ config(materialized='table') }}

with source as (
    select * from {{ source('northwind', 'products') }}
),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(product_id as int64) as ID_PRODUTO,
        cast(supplier_id as int64) as ID_FORNECEDOR,
        cast(category_id as int64) as ID_CATEGORIA,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(product_name) as NOME_PRODUTO,

        -- Lembrete: quantity_per_unit pode conter valores como "24 - 12 oz bottles"
        {{clean_string('quantity_per_unit')}} as QUANTIDADE_POR_UNIDADE,

        cast(units_in_stock as int64) as UNIDADES_EM_ESTOQUE,
        cast(units_on_order as int64) as UNIDADES_POR_PACOTE,
        cast(reorder_level as int64) as NIVEL_DE_REPOSICAO,

        -- transformações de valores monetários (Casting para NUMERIC)
        cast(unit_price as numeric) as PRECO_UNITARIO,

        -- transformação de booleanos (Casting para BOOLEAN)
        case when discontinued = 1 then 'SIM' else 'NAO' end as DESCONTINUADO,

        -- Engenharia de variáveis (adicionando novas colunas para enriquecimento de dados)
        cast((unit_price * units_in_stock) as numeric) as VALOR_ESTOQUE,
        -- Status do estoque: Esgotado, Estoque Baixo ou Estoque Normal
        case 
            when units_in_stock = 0 then 'ESGOTADO'
            when units_in_stock < reorder_level then 'ESTOQUE BAIXO'
            else 'ESTOQUE NORMAL'
        end as STATUS_ESTOQUE,
        
        -- Necessidade de Reposição: Sim ou Não
        case 
            when units_in_stock <= reorder_level and discontinued = 0 then "SIM" 
            else "NAO" 
        end as NECESSARIO_REPOR

    from source
)

select * from renamed