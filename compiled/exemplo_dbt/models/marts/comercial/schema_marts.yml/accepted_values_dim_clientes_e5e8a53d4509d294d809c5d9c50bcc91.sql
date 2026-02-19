
    
    

with all_values as (

    select
        CLASSIFICACAO_CLIENTE as value_field,
        count(*) as n_records

    from `projetodbt-479518`.`dbt_marts`.`dim_clientes`
    group by CLASSIFICACAO_CLIENTE

)

select *
from all_values
where value_field not in (
    'VIP','Ouro','Prata','Bronze','Sem Classe'
)


