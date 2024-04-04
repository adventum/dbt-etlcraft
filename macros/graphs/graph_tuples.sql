{%- macro graph_tuples(
  params = none,
  override_target_metadata=none,
  stage_name=none
  ) -%}


{%- set metadata_dict = fromyaml(override_target_metadata or etlcraft.metadata()) -%}
{%- set glue_models = metadata_dict['glue_models'] -%}
{%- set query_test = '' -%}

{%- for table, data in glue_models.items() -%}
    {% set cols = data['cols'] %}
    {% set datetime_field = data['datetime_field'] %}
    {%- set query = '' -%}
    

    {%- if not loop.first %}
        {{ query ~ 'union all' }}
    {% endif -%}

    {%- for col in cols[1:] -%}

        {%- if not loop.first %}
            {{ query ~ 'union all' }}
        {% endif -%}
        {%- set tmp -%}
        
            select
                    tuple(toLowCardinality(__link), {{ datetime_field }},  __id) as hash,
                    tuple(toLowCardinality('{{ col }}'), toDateTime(0),  {{ col }}) as node_left
            from {{ target.schema }}.{{ table }}
            where nullIf({{ col }}, '') is not null
        {%- endset -%}
        {{ config(
           materialized='table',
           on_schema_change='fail'
        ) }}

        {{ query ~ tmp  }}

    {%- endfor -%}
{%- endfor -%}

{% endmacro %}