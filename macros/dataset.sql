{% macro dataset(
    defaults_dict=etlcraft.etlcraft_defaults(), disable_incremental=False,
    source_table='master', database = 'marts', templates = none, account = none,
    defaults_field = '__table_name'
) %}

{% set table_exists = etlcraft.check_table_exists(source_table,database) %}
{{        
    config(schema=database)   
     }}

{% if not table_exists %}
    SELECT 'Мастер таблица не создана' as field_0
{% else %}

    SELECT
        *
    FROM {{ ref(source_table) }}
{% if templates is not none or account is not none %}
    WHERE 
    {% if templates is none and account is none %}
        ({{ etlcraft.like_query_cycle(templates,defaults_field) }})
        AND
        ({{ etlcraft.like_query_cycle(account,defaults_field) }})
    {% endif %}

    {% if templates is not none and account is none %}
        {{ etlcraft.like_query_cycle(templates,defaults_field) }}
    {% endif %}
                
    {% if templates is none and account is not none %}
        {{ etlcraft.like_query_cycle(account,defaults_field) }}
    {% endif %}
{% endif %}

{% endif %}    

{% endmacro %}