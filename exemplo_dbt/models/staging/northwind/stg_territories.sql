{{ config(materialized='table') }}


with 

source as (
    select * from {{ source('northwind', 'territories') }}

),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(territory_id as int64) as ID_TERRITORIO,
        cast(territory_description as string) as DESCRICAO_TERRITORIO,
        cast(region_id as int64) as ID_REGIAO

    from source
)

select * from renamed