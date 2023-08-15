{% macro clickhouse__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database) %}
        select distinct
            table_schema as {{ adapter.quote("table_schema") }},
            table_name as {{ adapter.quote("table_name") }},
            {{ dbt_utils.get_table_types_sql() }}
        from information_schema.tables
        where table_schema ilike '{{ schema_pattern }}'
        and table_name ilike '{{ table_pattern }}'
        and table_name not ilike '{{ exclude }}'
{% endmacro %}

{% macro clickhouse__get_table_types_sql() %}
            case toString(table_type)
                when 'BASE TABLE' then 'table'
                when 'EXTERNAL TABLE' then 'external'
                when 'MATERIALIZED VIEW' then 'materializedview'
                else lower(toString(table_type))
            end as {{ adapter.quote('table_type') }}
{% endmacro %}

{% macro clickhouse__get_relations_by_prefix(schema, prefix, exclude='', database=target.database) %}
    {%- call statement('get_tables', fetch_result=True) %}
      {{ dbt_utils.get_tables_by_prefix_sql(schema, prefix, exclude, database) }}
    {%- endcall -%}
    {%- set table_list = load_result('get_tables') -%}
    {%- if table_list and table_list['table'] -%}
        {%- set tbl_relations = [] -%}
        {%- for row in table_list['table'] -%}
            {%- set tbl_relation = api.Relation.create(
                database=None,
                schema=row.table_schema,
                identifier=row.table_name,
                type=row.table_type
            ) -%}
            {%- do tbl_relations.append(tbl_relation) -%}
        {%- endfor -%}
        {{ return(tbl_relations) }}
    {%- else -%}
        {{ return([]) }}
    {%- endif -%}
{% endmacro %}

{% macro clickhouse__get_relations_by_pattern(schema_pattern, table_pattern, exclude='', database=target.database) %}
    {%- call statement('get_tables', fetch_result=True) %}

      {{ dbt_utils.get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude, database) }}

    {%- endcall -%}

    {%- set table_list = load_result('get_tables') -%}

    {%- if table_list and table_list['table'] -%}
        {%- set tbl_relations = [] -%}
        {%- for row in table_list['table'] -%}
            {%- set tbl_relation = api.Relation.create(
                database=None,
                schema=row.table_schema,
                identifier=row.table_name,
                type=row.table_type
            ) -%}
            {%- do tbl_relations.append(tbl_relation) -%}
        {%- endfor -%}

        {{ return(tbl_relations) }}
    {%- else -%}
        {{ return([]) }}
    {%- endif -%}

{% endmacro %}