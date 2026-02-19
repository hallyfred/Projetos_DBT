
    
    

with dbt_test__target as (

  select territory_id as unique_field
  from `projetodbt-479518`.`dbt`.`territories`
  where territory_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


