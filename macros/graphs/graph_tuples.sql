{%- macro graph_tuples(
  params = none,
  override_target_metadata=none,
  stage_name=none,
  limit0=none
  ) -%}

{# Извлекаем метаданные или используем метаданные по умолчанию #}
{%- set metadata_dict = fromyaml(override_target_metadata or etlcraft.metadata(override_target_metadata)) -%}
{# Получаем модели склейки из метаданных #}
{%- set glue_models = metadata_dict['glue_models'] -%}

{# Цикл по моделям склейки #}
{%- for table, data in glue_models.items() -%}
    {% set cols = data['cols'] %}
    {% set datetime_field = data['datetime_field'] %}
    {%- set query = '' -%}
    
    {# Проверяем, не первая ли это итерация #}
    {%- if not loop.first %}
        {{ query ~ 'union all' }}
    {% endif -%}

    {# Цикл по колонкам текущей модели склейки #}
    {%- for col in cols[1:] -%}

        {# Если это не первая итерация в цикле, добавляем оператор объединения #}
        {%- if not loop.first %}
            {{ query ~ 'union all' }}
        {% endif -%}
        {%- set tmp -%}
        
            {# Создаем SQL-запрос для текущей колонки #}
            select
                    tuple(toLowCardinality(__link), {{ datetime_field }},  __id) as hash,
                    tuple(toLowCardinality('{{ col }}'), toDateTime(0),  {{ col }}) as node_left
            from {{ target.schema }}.{{ table }}
            where nullIf({{ col }}, '') is not null
            {% if limit0 %}
            LIMIT 0
            {%- endif -%}

        {%- endset -%}
        
        {# Создаем таблицу с результатом запроса #}
        {{ config(
           materialized='table',
           on_schema_change='fail'
        ) }}
        
        {# Добавляем SQL-запрос в общий запрос #}
        {{ query ~ tmp  }}

    {%- endfor -%}
{%- endfor -%}

{% endmacro %}
