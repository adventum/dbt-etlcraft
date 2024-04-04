{{
    config(
        materialized = 'table',
        order_by = ('__datetime')
    )
}}


SELECT 
* 
FROM  {{ ref('hash_datestat') }}

