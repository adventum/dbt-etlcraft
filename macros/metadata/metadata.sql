{%- macro metadata(override_target_metadata=none, vars=none) -%}

{#- в этом макросе мы определяем, какая версия метадаты будет использоваться -#}


{#- либо используется та метадата, название которой передал пользователь напрямую в модели через аргумент -#}
{%- if override_target_metadata -%} 
    {{ etlcraft[override_target_metadata](features = etlcraft.get_features()) }}

{#- либо используется та метадата, название которой передаётся в Aiflow при запуске dbt run c vars -#}
{%- elif vars -%}
    {{ etlcraft['{{ var("override_target_metadata") }}'](features = etlcraft.get_features()) }}

{#- либо, если ничего нигде не передаётся, то используется последняя версия метадаты -#}
{%- else -%} 
    {%- set last_override_target_metadata = 'metadata_1' -%}
    {{ etlcraft[last_override_target_metadata](features = etlcraft.get_features()) }}

{%- endif -%}
{% endmacro %}

{# вместо override_target_metadata было metadata_name #}
