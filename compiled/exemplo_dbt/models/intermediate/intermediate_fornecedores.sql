

with suppliers as (select * from `projetodbt-479518`.`dbt_staging`.`stg_suppliers`),

intermediate_fornecedores as (
    select ID_FORNECEDOR,
        NOME_EMPRESA,
        NOME_CONTATO,
        CARGO_CONTATO,
        ENDERECO,
        CIDADE,
        REGIAO,
        CEP,
        PAIS,
        case 
            when pais in ('USA', 'CANADA', 'BRAZIL') then 'AMERICA'
            when pais in ('UK', 'FRANCE', 'GERMANY', 'ITALY', 'SPAIN',
            'FINLAND', 'NETHERLANDS', 'SWEDEN', 'DENMARK','NORWAY') then 'EUROPA'
            when pais in ('JAPAN', 'SINGAPORE') then 'ÁSIA'
            WHEN pais in ('AUSTRALIA') then 'OCEANIA'
            else 'OUTROS'
        end as REGIAO_FORNECEDOR,
        TELEFONE,
        FAX,
        HOME_PAGE

    from suppliers
)

select * from intermediate_fornecedores