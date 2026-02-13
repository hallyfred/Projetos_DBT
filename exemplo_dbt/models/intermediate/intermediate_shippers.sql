{{ config(
    materialized = 'ephemeral',
    schema = 'intermediate'
) }}

WITH SHIPPERS AS (
    SELECT * FROM {{ ref('stg_shippers') }}
),

FINAL AS (
    SELECT
        -- CHAVE PRIMÁRIA
        ID_TRANSPORTADORA,
        
        -- INFORMAÇÕES DA EMPRESA
        NOME_EMPRESA,
        
        -- CONTATO
        TELEFONE,

        -- ENGENHARIA DE ATRIBUTOS 
        -- IDENTIFICANDO O TIPO DE CONTATO DISPONÍVEL
        CASE 
            WHEN TELEFONE IS NOT NULL THEN 'COM TELEFONE'
            ELSE 'SEM TELEFONE'
        END AS STATUS_CONTATO
        
    FROM SHIPPERS
)

SELECT * FROM FINAL