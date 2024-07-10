{%- macro metadata(override_target_metadata=none) -%}

{#- в этом макросе мы определяем, какая версия метадаты будет использоваться -#}

{%- if override_target_metadata -%} {# либо используется та метадата, название которой передал пользователь #}
    {{ etlcraft[override_target_metadata](features = etlcraft.get_features()) }}
{%- else -%} {# либо, если пользователь ничего не передал, используется последняя версия #}
    {%- set last_override_target_metadata = 'metadata_1' -%}
    {{ etlcraft[last_override_target_metadata](features = etlcraft.get_features()) }}
{%- endif -%}

{% endmacro %}

{# вместо override_target_metadata было metadata_name #}
