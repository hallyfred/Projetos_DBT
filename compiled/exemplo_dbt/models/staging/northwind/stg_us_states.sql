


with source as (
    select * from `projetodbt-479518`.`dbt`.`us_states`),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(state_id as int64) as ID_ESTADO,
        cast(state_name as string) as NOME_ESTADO,
        cast(state_abbr as string) as SIGLA_ESTADO,
        cast(state_region as string) as REGIAO_ESTADO
        
        from source)

select * from renamed