{{ config(materialized='ephemeral') }}

with territories as (
    select * from {{ ref('stg_territories') }}
),

regions as (
    select * from {{ ref('stg_region') }}
),

us_states as (
    select * from {{ ref('stg_us_states') }}
),

joined as (
    select
        -- Territórios
        t.ID_TERRITORIO,
        trim(t.DESCRICAO_TERRITORIO) as DESCRICAO_TERRITORIO,
        
        -- Regiões (Usando a nova coluna SIGLA_REGIAO que criamos na camada staging para facilitar o join)
        r.ID_REGIAO,
        r.DESCRICAO_REGIAO,
        r.SIGLA_REGIAO,
        
        -- Estados 
        s.ID_ESTADO,
        s.NOME_ESTADO,
        s.SIGLA_ESTADO
       
        
    from territories t
    inner join regions r on t.ID_REGIAO = r.ID_REGIAO
   
    left join us_states s on lower(trim(r.SIGLA_REGIAO)) = lower(trim(s.REGIAO_ESTADO))
)

select * from joined