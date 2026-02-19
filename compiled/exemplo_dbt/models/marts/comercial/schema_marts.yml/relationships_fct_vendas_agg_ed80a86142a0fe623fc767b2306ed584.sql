
    
    

with child as (
    select ID_CLIENTE as from_field
    from `projetodbt-479518`.`dbt_marts`.`fct_vendas_agg`
    where ID_CLIENTE is not null
),

parent as (
    select ID_CLIENTE as to_field
    from `projetodbt-479518`.`dbt_marts`.`dim_clientes`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


