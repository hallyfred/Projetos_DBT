{{ config(materialized='table') }}

with source as (
    select * from {{ source('northwind', 'employees') }}
),

renamed as (select
    -- transformações de chaves (IDs)
    cast(employee_id as int64) as id_colaborador,
    cast(reports_to as int64) as id_gestor,


    -- engenharia de variáveis (adicionando colunas de idade do colaborador e tempo de casa)
    date_diff(current_date(), cast(birth_date as date), year) as idade_colaborador,
    date_diff(current_date(), cast(hire_date as date), year) as anos_empresa,

    -- transformações de datas: Usando Macros para converter para formato BR
    {{ format_br_date('hire_date') }} as data_contratacao,
    {{ format_br_date('birth_date') }} as data_nascimento,


    -- transformações de strings
    cast(last_name as string) as sobrenome,
    cast(first_name as string) as nome,
    cast(title as string) as cargo,
    cast(title_of_courtesy as string) as titulo_cortesia,
    cast(address as string) as endereco,
    cast(city as string) as cidade,
    cast(region as string) as regiao,
    cast(postal_code as string) as cep,
    cast(country as string) as pais,
    cast(home_phone as string) as telefone_residencial,
    cast(extension as string) as ramal
    
    from source )


select * from renamed