{{config(materialized='table')}}

with source as (select * from {{source('northwind', 'shippers')}}),


renamed as (
    select
        -- transformações de chaves (IDs)
        cast(shipper_id as int64) as id_transportadora,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(lower(company_name)) as nome_empresa,
        trim(phone) as telefone

    from source
)

select * from renamed