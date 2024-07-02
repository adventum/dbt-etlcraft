{%- macro metadata(metadata_name=none) -%}

{#- в этом макросе мы определяем, какая версия метадаты будет использоваться -#}

{%- if metadata_name -%} {# либо используется та метадата, название которой передал пользователь #}
    {{ etlcraft[metadata_name](features = etlcraft.get_features()) }}
{%- else -%} {# либо, если пользователь ничего не передал, используется последняя версия #}
    {{ etlcraft.metadata_1(features = etlcraft.get_features()) }}
{%- endif -%}

{% endmacro %}