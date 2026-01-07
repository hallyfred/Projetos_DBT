


-- Macro para remover acentos de strings

{% macro remove_accents(column_name) %}
    TRANSLATE(
        {{ column_name }},
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
{% endmacro %}