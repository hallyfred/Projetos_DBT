{{config(materialized='table')}}

with source as (select * from {{source('northwind', 'shippers')}}),


renamed as (
    select
        -- transformações de chaves (IDs)
        cast(shipper_id as int64) as ID_TRANSPORTADORA,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(upper(company_name)) as NOME_EMPRESA,
        trim(phone) as TELEFONE
    from source
)

select * from renamed