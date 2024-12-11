------------------
--- CLICKHOUSE ---
------------------
{%- macro custom_hash(field_list) -%}

    {%- for key in field_list.keys() -%}
    {%- set fields = [] -%}
    {%- for line in field_list[key] -%}
        {%- set _ = fields.append(
            "ifNull(nullIf(upper(trim(toString(" ~ line ~ "))), ''), '^^')"
        ) -%}

        {%- if not loop.last %}
            {%- set _ = fields.append("'||'") -%}
        {%- endif -%}

    {%- endfor -%}
    {{ clickhouse__hash(clickhouse__concat(fields)) }} as {{ key }}
    {%- if not loop.last -%} , 
    {% endif -%}
    {%- set fields = [] -%}
    {%- endfor -%}

{%- endmacro -%}