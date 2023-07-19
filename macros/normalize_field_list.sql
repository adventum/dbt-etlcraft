{% macro normalize_field_list(from_expression, field_list) %}

    {% set select_columns = [] %}

    {% for field in field_list %}
        {% set json_extract_query = json_extract_string('_airbyte_data', field) %}
        {% set normalized_name = normalize_name(field) %}
        {% set select_columns = select_columns.append(json_extract_query ~ ' AS ' ~ adapter.quote(normalized_name)) %}
    {% endfor %}

    {% set select_columns = select_columns + ['_airbyte_ab_id', '_airbyte_emitted_at', 'now() as _normalized_at', 'table_name as _table_name'] %}
    {% set select_query = 'SELECT ' ~ select_columns|join(', ') ~ ' FROM (' ~ from_expression ~ ')' %}

    {{ return(select_query) }}

{% endmacro %}