
    
    

with dbt_test__target as (

  select region_id as unique_field
  from `projetodbt-479518`.`dbt`.`region`
  where region_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


