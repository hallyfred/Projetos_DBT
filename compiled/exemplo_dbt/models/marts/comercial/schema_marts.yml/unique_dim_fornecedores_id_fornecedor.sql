
    
    

with dbt_test__target as (

  select id_fornecedor as unique_field
  from `projetodbt-479518`.`dbt_marts`.`dim_fornecedores`
  where id_fornecedor is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


