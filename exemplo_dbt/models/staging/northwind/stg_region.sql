{{ config(materialized='table') }}


with source as (select * from {{source('northwind', 'region')}}),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(region_id as int64) as ID_REGIAO,
        cast(region_description as string) as DESCRICAO_REGIAO,
        -- adicionando a nova coluna SIGLA_REGIAO para facilitar joins com a tabela us_states
        case when
        region_description = 'Eastern' then 'east'
        when region_description = 'Western' then 'west'
        when region_description = 'Northern' then 'north'
        when region_description = 'Southern' then 'south'
        else 'other' end as SIGLA_REGIAO

    from source
)

select * from renamed