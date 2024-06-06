{%- macro zero_date() -%}
    {{ return(adapter.dispatch('zero_date', 'etlcraft')()) }}
{%- endmacro %}

{#- этот макрос нужен, чтобы для разных типов баз данных сгенерировать дефолтное поле с датой -#}

{% macro default__zero_date() -%}
    {%- set field = ('1970-01-01') -%}
    {{ field }}
{%- endmacro %}


{% macro clickhouse__zero_date() %}
    {%- set field = 0 -%} {# пишем ноль - CH выдаст toDateTime(0) как '1970-01-01 00:00:00' #}
    {{ field }}
{%- endmacro %}

{% macro bigquery__zero_date() %}
    {%- set field = ('1970-01-01') -%}
    {{ field }}
{%- endmacro %}