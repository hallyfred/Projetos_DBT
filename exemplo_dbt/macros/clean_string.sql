
-- Macro para limpar strings, remover acentos, caracteres especiais, espaços em branco desnecessários e tornar todos os nomes maiusculos

{% macro clean_string(column_name) %}
    TRIM(
        REGEXP_REPLACE(
            {{ remove_accents("UPPER(" ~ column_name ~ ")") }},
            r'[^A-Z0-9 ]', ''
        )
    )
{% endmacro %}