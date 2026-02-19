
    
    

with all_values as (

    select
        STATUS_ESTOQUE as value_field,
        count(*) as n_records

    from `projetodbt-479518`.`dbt_staging`.`stg_products`
    group by STATUS_ESTOQUE

)

select *
from all_values
where value_field not in (
    'ESGOTADO','ESTOQUE BAIXO','ESTOQUE NORMAL'
)


