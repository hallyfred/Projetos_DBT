{{ config(materialized='table') }}


with 

source as (
    select * from {{ source('northwind', 'orders') }}
),

renamed as (
    select
        -- transformações de chaves (IDs)
        cast(order_id as int64) as ID_PEDIDO,
        cast(customer_id as string) as ID_CLIENTE,
        cast(employee_id as int64) as ID_COLABORADOR,
        cast(ship_via as int64) as ID_TRANSPORTADORA, 

        -- transformações de datas: Usando Macros para converter para formato BR

        {{ format_br_date('order_date') }} as DATA_PEDIDO,
        {{ format_br_date('required_date') }} as DATA_REQUISICAO,
        {{ format_br_date('shipped_date') }} as DATA_EMBARQUE,

        -- trnasformações de valores monetários (Casting para NUMERIC)
        cast(freight as numeric) as VALOR_FRETE,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(ship_name) as NOME_DESTINATARIO,
        trim(ship_address) as ENDERECO_ENTREGA,
        trim(ship_city) as CIDADE_ENTREGA,
        trim(ship_region) as REGIAO_ENTREGA,
        trim(ship_postal_code) as CEP_ENTREGA,
        trim(ship_country) as PAIS_ENTREGA,

        -- Adicionando novas colunas para enriquecimento de dados

        -- tempo até o embarque do pedido (em dias)
        date_diff(cast(shipped_date as date), cast(order_date as date), day) as DIAS_PROCESSAMENTO,
          
        -- Status de embarque: Pedido Enviado ou Pendente?
        case when shipped_date is null then 'ENVIO PENDENTE' else 'ENVIADO' end as STATUS_EMBARQUE,
        -- Pedido Atrasado: Sim ou Não?
        case 
            when shipped_date is null or required_date > shipped_date then "SIM" 
            else "NÃO" 
        end as PEDIDO_ATRASADO



    from source
)

select * from renamed