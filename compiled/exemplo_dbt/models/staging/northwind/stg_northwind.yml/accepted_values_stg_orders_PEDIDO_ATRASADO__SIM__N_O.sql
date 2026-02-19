
    
    

with all_values as (

    select
        PEDIDO_ATRASADO as value_field,
        count(*) as n_records

    from `projetodbt-479518`.`dbt_staging`.`stg_orders`
    group by PEDIDO_ATRASADO

)

select *
from all_values
where value_field not in (
    'SIM','NÃO'
)


