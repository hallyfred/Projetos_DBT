{{ config(materialized='table') }}

with source as (select * from {{source('northwind', 'customers')}}),


renamed as (
    select
        -- transformações de chaves (IDs)
        cast(customer_id as string) as ID_CLIENTE,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        {{clean_string('company_name')}} as NOME_EMPRESA,
        {{clean_string('contact_name')}} as NOME_CONTATO,
        {{clean_string('contact_title')}} as CARGO_CONTATO,
        {{clean_string('address')}} as ENDERECO,
        {{clean_string('city')}} as CIDADE,
        {{clean_string('region')}} as REGIAO,
        {{clean_string('postal_code')}} as CEP,
        {{clean_string('country')}} as PAIS,
        {{clean_string('phone')}} as TELEFONE,
        {{clean_string('fax')}} as FAX

    from source
)

select * from renamed