
    
    

with all_values as (

    select
        STATUS_EMBARQUE as value_field,
        count(*) as n_records

    from `projetodbt-479518`.`dbt_staging`.`stg_orders`
    group by STATUS_EMBARQUE

)

select *
from all_values
where value_field not in (
    'ENVIADO','ENVIO PENDENTE'
)


