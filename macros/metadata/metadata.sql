{%- macro metadata(override_target_metadata=none, features_list=none) -%}

{#- в этом макросе мы определяем, какая версия метадаты будет использоваться -#}


{#- либо используется та метадата, название которой передал пользователь напрямую в модели через аргумент -#}
{%- if override_target_metadata -%} 
{{ log('I am metadata and I will listen to override_target_metadata', true) }}
    {{ etlcraft[override_target_metadata](features_list) }}
{{ log('I am metadata and my override_target_metadata is:', true) }} 
{{ log(override_target_metadata, true) }}


{#- либо, если ничего нигде не передаётся, то используется последняя версия метадаты -#}
{%- else -%} 
    {%- set last_override_target_metadata = 'metadata_1' -%}
    {{ etlcraft[last_override_target_metadata](features_list) }}


{%- endif -%}
{% endmacro %}
