
    
    

with dbt_test__target as (

  select ID_ESTADO as unique_field
  from `projetodbt-479518`.`dbt_staging`.`stg_us_states`
  where ID_ESTADO is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


