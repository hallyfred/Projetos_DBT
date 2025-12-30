{{ config(materialized='table') }}

with source as (select * from {{source('northwind', 'customers')}}),


renamed as (
    select
        -- transformações de chaves (IDs)
        cast(customer_id as string) as id_cliente,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(company_name) as nome_empresa,
        trim(contact_name) as nome_contato,
        trim(contact_title) as cargo_contato,
        trim(address) as endereco,
        trim(city) as cidade,
        trim(region) as regiao,
        trim(postal_code) as cep,
        trim(country) as pais,
        trim(phone) as telefone,
        trim(fax) as fax

    from source
)

select * from renamed