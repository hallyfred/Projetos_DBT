

with source as (select * from `projetodbt-479518`.`dbt`.`customers`),


renamed as (
    select
        -- transformações de chaves (IDs)
        cast(customer_id as string) as ID_CLIENTE,

        -- limpeza de strings (Remoção de espaços em branco desnecessários)
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(company_name),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as NOME_EMPRESA,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(contact_name),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as NOME_CONTATO,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(contact_title),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as CARGO_CONTATO,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(address),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as ENDERECO,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(city),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as CIDADE,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(region),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as REGIAO,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(postal_code),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as CEP,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(country),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as PAIS,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(phone),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as TELEFONE,
        
    TRIM(
        REGEXP_REPLACE(
            
    TRANSLATE(
        UPPER(fax),
        'áàâãäéèêëíìîïóòôõöúùûüçñÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑ',
        'aaaaaeeeeiiiiooooouuuucnAAAAAEEEEIIIIOOOOOUUUUCN'
    )
,
            r'[^A-Z0-9 ]', ''
        )
    )
 as FAX

    from source
)

select * from renamed