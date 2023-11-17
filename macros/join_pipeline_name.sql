{%- macro join_pipeline_name(macro_name, source_types, streams, templates) -%}
    
    {% if macro_name == 'mobile_event' %}
        {{etlcraft.join_mobile_event(source_types, streams, templates)}}
    {% elif macro_name == 'mobile_install' %}
        {{etlcraft.join_mobile_install(source_types, streams, templates)}}
    {% endif %}
    
{%- endmacro -%}