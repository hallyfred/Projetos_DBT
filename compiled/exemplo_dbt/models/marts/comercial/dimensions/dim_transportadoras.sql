

with  __dbt__cte__intermediate_shippers as (


WITH SHIPPERS AS (
    SELECT * FROM `projetodbt-479518`.`dbt_staging`.`stg_shippers`
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
), transportadoras as (

    select
       *
    from __dbt__cte__intermediate_shippers
)

select * from transportadoras