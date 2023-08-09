/* The name of the model for this macro must match the pattern incremental_{sourcetypename}_{templatename}_{streamname}. 
It finds a table with prefix normalize_{sourcetypename}_{templatename}_{streamname} and makes select * from it.
Also it determines the incremental datetime field (IDF) of the table using the macro find_incremental_datetime_field 
(if the argument incremental_datetime_field is not provided).
If IDF is not found, it just materializes the normalize_ relation (if it is a view, otherwise serves like a proxy view for normalize_)
If there is an IDF, it makes incremental model. In this case it casts IDF to datetime using macro cast_datetime_field.

How incremental model works:
1. The table is indexed by IDF (primary) and table_name (secondary)
2. In pre_hook we delete from the current table the rows where the dates of the IDF fields are the dates that are in the normalized relation (taking into account the table name)
3. All the data from normalized relation is inserted into the current table.

For example, let the incremental table A contain the rows from table B for dates 01.07-03.07 and from table C for dates 02.07-04.07.
The normalized relation contains the rows from table B and C for date 03.07-05.07. After the normalization, the old rows 
of A from table B for date 03.07 and from table C for dates 03.07 and 04.07 will be removed. After that the whole content
of the normalized relation will be inserted into A.
*/

{% macro incremental_table(incremental_datetime_field=None) %}

{% set model_name = this.name %}

{# Verify the naming convention of the model #}
{% if not model_name.startswith('incremental_') %}
    {{ exceptions.raise_compiler_error("Model name does not match the expected naming convention: 'incremental_{sourcetypename}_{templatename}_{streamname}'.") }}
{% endif %}

{# Derive the normalized relation's name from the incremental model's name #}
{% set model_name_parts = model_name.split('_') %}
{% set normalized_relation = 'normalize_' + model_name_parts[1] + '_' + model_name_parts[2] + '_' + model_name_parts[3] %}

{# Determine the incremental datetime field (IDF) if not provided #}
{% if not incremental_datetime_field %}
    {% set incremental_datetime_field = find_incremental_datetime_field(normalized_relation) %}
{% endif %}

{# If IDF is not found, treat this as a simple proxy #}
{% if not incremental_datetime_field  %}
    SELECT * FROM {{ ref(normalized_relation) }}
{# If IDF exists, create an incremental model #}
{% else %}
    
    {{ config(
        materialized='incremental',
        order_by=tuple(incremental_datetime_field, '_table_name'),
        pre_hook=[
            "DELETE WHERE tuple({{ incremental_datetime_field }}, _table_name) 
              IN (SELECT DISTINCT tuple(({{ cast_datetime_field(incremental_datetime_field) }}, _table_name) 
              FROM {{ ref(normalized_relation) }}) 
            FROM {{ this }}"
        ]
    ) }}

    SELECT * REPLACE(
    {{ cast_datetime_field(incremental_datetime_field) }} AS {{ incremental_datetime_field }}),    
    FROM {{ ref(normalized_relation) }}

{% endif %}

{% endmacro %}