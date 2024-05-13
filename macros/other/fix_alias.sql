{%- macro fix_alias(
    override_target_model_name=none
    ) -%}

{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set last_model_name_part = model_name_parts[-1] -%}
    {%- if last_model_name_part=='manual' -%}
        {%- set model_name_parts_without_last = model_name_parts[:-2]-%}
        {%- set table_name = '_'.join(model_name_parts_without_last) -%}
    {%- else -%}
        {%- set table_name = '_'.join(model_name_parts) -%}
    {%- endif -%}

{{ config(alias=table_name) }}

{%- endmacro %}