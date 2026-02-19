
    
    

with dbt_test__target as (

  select id_transportadora as unique_field
  from `projetodbt-479518`.`dbt_marts`.`dim_transportadoras`
  where id_transportadora is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


