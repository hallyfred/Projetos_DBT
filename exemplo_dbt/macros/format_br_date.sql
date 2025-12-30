{% macro format_br_date(column_name) %}

    {%- set adapter_type = adapter.type() -%}

    {%- if adapter_type == 'bigquery' -%}
        -- Para BigQuery: utiliza FORMAT_DATE
        safe.format_date('%d/%m/%Y', cast({{ column_name }} as date))

    {%- elif adapter_type == 'athena' or adapter_type == 'presto' -%}
        -- Para AWS Athena: utiliza date_format
        date_format(cast({{ column_name }} as date), '%d/%m/%Y')

    {%- elif adapter_type == 'oracle' -%}
        -- Para Oracle: utiliza TO_CHAR
        to_char(cast({{ column_name }} as date), 'DD/MM/YYYY')

    {%- else -%}
        -- Fallback genérico (padrão SQL ou erro amigável)
        cast({{ column_name }} as string)
        
    {%- endif -%}

{% endmacro %}