{{config( materialized='ephemeral'
)}}

WITH EMPLOYEES AS (
    SELECT * FROM {{ ref('stg_employees') }}
),

FINAL AS (
    SELECT
        -- Chaves
        EMP.ID_COLABORADOR,
        
        -- Informações do Colaborador
        EMP.NOME || ' ' || EMP.SOBRENOME AS NOME_COMPLETO,
        EMP.CARGO,
        EMP.TITULO_CORTESIA,
        
        -- Hierarquia (Self-Join para buscar o nome do Gestor)
        -- Usamos COALESCE para o CEO ou cargos que não possuem gestor
        COALESCE(GESTOR.NOME || ' ' || GESTOR.SOBRENOME, 'DIRETORIA') AS NOME_GESTOR,
        
        -- Dados de Tempo e Idade
        EMP.DATA_CONTRATACAO,
        EMP.ANOS_EMPRESA,
        CASE 
            WHEN EMP.ANOS_EMPRESA <= 2 THEN '0-2 ANOS'
            WHEN EMP.ANOS_EMPRESA <= 5 THEN '3-5 ANOS'
            ELSE 'MAIS DE 5 ANOS'
        END AS FAIXA_TEMPO_EMPRESA,
        
        EMP.DATA_NASCIMENTO,
        EMP.IDADE_COLABORADOR,
        CASE 
            WHEN EMP.IDADE_COLABORADOR < 30 THEN 'ATÉ 30 ANOS'
            WHEN EMP.IDADE_COLABORADOR <= 50 THEN '30-50 ANOS'
            ELSE 'MAIS DE 50 ANOS'
        END AS FAIXA_ETARIA,
        
        -- Localização
        EMP.CIDADE,
        EMP.REGIAO,
        EMP.PAIS,
        
        -- Contato
        EMP.TELEFONE_RESIDENCIAL,
        EMP.RAMAL

    FROM EMPLOYEES EMP
    LEFT JOIN EMPLOYEES GESTOR ON EMP.ID_GESTOR = GESTOR.ID_COLABORADOR
)

SELECT * FROM FINAL