{{ config(materialized='table') }}


with 

source as (
    select * from {{ source('northwind', 'orders') }}
),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(order_id as int64) as id_pedido,
        cast(customer_id as string) as id_cliente,
        cast(employee_id as int64) as id_colaborador,
        cast(ship_via as int64) as id_transportadora, 

        -- transformações de datas (Casting para DATE)
        cast(order_date as date) as data_pedido,
        cast(required_date as date) as data_requisicao,
        cast(shipped_date as date) as data_embarque,

        -- trnasformações de valores monetários (Casting para NUMERIC)
        cast(freight as numeric) as valor_frete,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(ship_name) as nome_destinatario,
        trim(ship_address) as endereco_entrega,
        trim(ship_city) as cidade_entrega,
        trim(ship_region) as regiao_entrega,
        trim(ship_postal_code) as cep_entrega,
        trim(ship_country) as pais_entrega

    from source
)

select * from renamed