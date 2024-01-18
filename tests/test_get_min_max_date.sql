{% set source_query %}
    SELECT 
    'dbt_test__audit' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    '__datetime' as name,
    '2023-12-01' as __datetime
    UNION all
    SELECT 
    'dbt_test__audit' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    'test_col2'as name,
    '2023-12-02' as __datetime
    UNION all
    SELECT 
    '' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    '__datetime' as name,
    '2023-12-03' as __datetime
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    '__datetime' as name,
    '2023-12-01' as __datetime
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col2' as name,
    '2023-12-02' as __datetime
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col3' as name,
    '2023-12-03' as __datetime
{% endset %}

{% set min_max_date = get_min_max_date('incremental','testsourcetypename','testtemplatename',source_query) %}

{% set date_from = min_max_date.get('date_from')[0] %}
{% set date_to = min_max_date.get('date_to')[0] %}

{% set date_from_str = min_max_date.get('date_from')[0] ~'' %}
{% set date_to_str = min_max_date.get('date_to')[0] ~''  %}

{%- set date_from_parts = date_from_str.split('-') -%}
{%- set date_to_parts = date_to_str.split('-') -%}

{%- set date_from_int = (date_from_parts[0]~date_from_parts[1]~date_from_parts[2])| int -%}
{%- set date_to_int = (date_to_parts[0]~date_to_parts[1]~date_to_parts[2])| int -%}


{% if date_from is undefined or date_to is undefined  %}
SELECT 'date var is undefined' 
{% elif date_from_int > date_to_int %} 
SELECT 'date_from greater then date_to' 
{% else %}
SELECT 'test' where 1!=1
{% endif %}