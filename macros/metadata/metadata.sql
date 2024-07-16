{%- macro metadata(override_target_metadata=none) -%}

{#- в этом макросе мы определяем, какая версия метадаты будет использоваться -#}


{#- либо используется та метадата, название которой передал пользователь напрямую в модели через аргумент -#}
{%- if override_target_metadata -%} 
{{ log('I am metadata and I will listen to override_target_metadata', true) }}
    {{ etlcraft[override_target_metadata](features = etlcraft.get_features()) }}
{{ log('I am metadata and my override_target_metadata is:', true) }} 
{{ log(override_target_metadata, true) }}
{{ log('--------------------------------- ', true) }}


{#- либо используется та метадата, название которой передаётся в Aiflow при запуске dbt run c vars -#}
{%- elif not override_target_metadata -%}
{{ log('I am metadata and I will listen to vars', true) }}
{{ log('I got this var:', true) }}
{{ log(var("metadata_name"), true) }}
    {{ etlcraft[var("metadata_name")](features = etlcraft.get_features()) }}


{#- либо, если ничего нигде не передаётся, то используется последняя версия метадаты -#}
{%- else -%} 
{{ log('I am metadata and I will listen to no one', true) }}
    {%- set last_override_target_metadata = 'metadata_1' -%}
    {{ etlcraft[last_override_target_metadata](features = etlcraft.get_features()) }}


{%- endif -%}
{% endmacro %}
