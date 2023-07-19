{%- macro get_from_default_dict(default_dict, path, default_return={}) -%}
    {% set ns = namespace(current_value=default_dict) %}
    {%- for key in path -%}
        {%- set ns.current_value = ns.current_value.get(key, '') -%}
        {%- if ns.current_value == '' -%}
            {{ return(default_return) }}
        {%- endif -%}
    {%- endfor -%}
    {{ return(ns.current_value) }}
{%- endmacro -%}