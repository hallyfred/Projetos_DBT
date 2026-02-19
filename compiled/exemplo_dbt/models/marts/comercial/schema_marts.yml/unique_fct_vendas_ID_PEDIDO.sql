
    
    

with dbt_test__target as (

  select ID_PEDIDO as unique_field
  from `projetodbt-479518`.`dbt_marts`.`fct_vendas`
  where ID_PEDIDO is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


