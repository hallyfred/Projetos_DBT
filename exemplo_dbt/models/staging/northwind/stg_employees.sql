{{ config(materialized='table') }}

with source as (
    select * from {{ source('northwind', 'employees') }}
),

renamed as (select
    -- transformações de chaves (IDs)
    cast(employee_id as int64) as ID_COLABORADOR,
    cast(reports_to as int64) as ID_GESTOR,


    -- engenharia de variáveis (adicionando colunas de idade do colaborador e tempo de casa)
    date_diff(current_date(), cast(birth_date as date), year) as IDADE_COLABORADOR,
    date_diff(current_date(), cast(hire_date as date), year) as ANOS_EMPRESA,

    -- transformações de datas: Usando Macros para converter para formato BR
    {{ format_br_date('hire_date') }} as DATA_CONTRATACAO,
    {{ format_br_date('birth_date') }} as DATA_NASCIMENTO,


    -- transformações de strings
    cast(last_name as string) as SOBRENOME,
    cast(first_name as string) as NOME,
    cast(title as string) as CARGO,
    cast(title_of_courtesy as string) as TITULO_CORTESIA,
    cast(address as string) as ENDERECO,
    cast(city as string) as CIDADE,
    cast(region as string) as REGIAO,
    cast(postal_code as string) as CEP,
    cast(country as string) as PAIS,
    cast(home_phone as string) as TELEFONE_RESIDENCIAL,
    cast(extension as string) as RAMAL

    from source )


select * from renamed