{% macro dataset( table_prefixes = none) %}

{{        
    config(
        materialized='table',
        order_by='toDate(__datetime)'
        )   
     }}

    SELECT
        *
    FROM {{ ref('master') }}
    {% if table_prefixes is not none %}
    WHERE 
        ({{ etlcraft.like_query_cycle(templates,'__table_name') }})
    {% endif %}    

{% endmacro %}