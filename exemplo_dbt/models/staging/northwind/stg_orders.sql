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

        -- transformações de datas: Usando Macros para converter para formato BR

        {{ format_br_date('order_date') }} as data_pedido_formatada,
        {{ format_br_date('required_date') }} as data_requisicao_formatada,
        {{ format_br_date('shipped_date') }} as data_embarque_formatada,
        
        -- trnasformações de valores monetários (Casting para NUMERIC)
        cast(freight as numeric) as valor_frete,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        trim(ship_name) as nome_destinatario,
        trim(ship_address) as endereco_entrega,
        trim(ship_city) as cidade_entrega,
        trim(ship_region) as regiao_entrega,
        trim(ship_postal_code) as cep_entrega,
        trim(ship_country) as pais_entrega,

        -- Adicionando novas colunas para enriquecimento de dados

        -- tempo até o embarque do pedido (em dias)
        date_diff(cast(shipped_date as date), cast(order_date as date), day) as dias_processamento,
          
        -- Status de embarque: Pedido Enviado ou Pendente?
        case when shipped_date is null then 'Envio Pendente' else 'Enviado' end as status_embarque,

        -- Pedido Atrasado: Sim ou Não?
        case 
            when shipped_date > required_date then "Sim" 
            else "Não" 
        end as pedido_atrasado,



    from source
)

select * from renamed