{{ config(materialized='table') }}

with source as (select * from {{source('northwind', 'suppliers')}}),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(supplier_id as int64) as id_fornecedor,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        {{clean_string('company_name')}} as nome_empresa,
        {{clean_string('contact_name')}} as nome_contato,
        {{clean_string('contact_title')}} as cargo_contato,
        {{clean_string('address')}} as endereco,
        {{clean_string('city')}} as cidade,
        {{clean_string('region')}} as regiao,
        {{clean_string('postal_code')}} as cep,
        {{clean_string('country')}} as pais,
        {{clean_string('phone')}} as telefone,
        {{clean_string('fax')}} as fax,
        {{clean_string('homepage')}} as home_page

    from source
)

select * from renamed