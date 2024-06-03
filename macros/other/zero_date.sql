{%- macro zero_date(
    datetime_field, 
    database_type
    ) -%}

{%- if database_type=='BQ' -%}
    {%- set field = toDateTime('1970-01-01') -%}
{%- else -%}
    {%- set field = toDateTime(0) -%}
{%- endif -%}
{%- endmacro %}