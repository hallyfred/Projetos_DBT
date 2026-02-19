
    
    

with all_values as (

    select
        CURVA_ABC as value_field,
        count(*) as n_records

    from `projetodbt-479518`.`dbt_marts`.`dim_produtos`
    group by CURVA_ABC

)

select *
from all_values
where value_field not in (
    'A','B','C'
)


