{{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}


SELECT 
*EXCEPT(_dbt_source_relation)
FROM  {{ ref('hash_datestat') }}

