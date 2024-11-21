{%- macro attr_create_events(
  params = none,
  model_name=none,
  limit0=none,
  attributions=attribution_models(),
  events_description=events() 
  ) -%}

{# 
    Настройка материализации данных.
    order_by=('qid', '__datetime','__link','__id') 
    определяет порядок сортировки данных по идентификатору группы, дате, ссылке и идентификатору.
#}
{{
    config(
        materialized='table', 
        order_by=('qid', '__datetime','__link','__id')  
    )
}}

{# 
    Извлечение метаданных и шагов воронки для формирования событий.
#}


{# проверяем, что "читает" содержимое макроса attribution_models#}
{% set test_output = attribution_models() %}
{{ log("test_output:"~test_output, info=True) }}

{% set funnel_steps = attributions[model_name]['funnel_steps'] %}
{% set step_name_list = [] %}
{% for step in funnel_steps %}
  {% do step_name_list.append(step['slug']) %}
{% endfor %}
{{log("step_name_list:"~step_name_list, true)}}

{% set steps =  events_description %}
{{log("steps:"~steps, true)}}

{# 
    Формирование событий с учетом приоритета шагов воронки.
    С помощью конструкции CASE WHEN производится сопоставление значений __link с ссылками на шаги воронки.
    Для каждого шага воронки вычисляется приоритет, который указывает на порядок шагов в воронке.
    Если событие не соответствует ни одному шагу воронки, ему присваивается приоритет 0.
    Каждому событию также присваивается идентификатор группы (qid), 
    дата, идентификатор ссылки (__link), идентификатор (__id) и шаг воронки (__step).
#}
select
    qid, 
    __link,
    CASE
    {% for step_name in step_name_list %}
        {%- set counter = loop.index -%}
        {%- for step_info in steps[step_name] -%}
            WHEN __link = '{{step_info.link}}' {% if 'condition' in step_info %} and {{step_info.condition}} {% endif %} THEN  {{ counter }}
        {% endfor %}
    {% endfor %}
    ELSE 0
    END as __priority, 
    __id,
    __datetime,
    toLowCardinality(
    CASE
    {% for step_name in step_name_list %}
        {%- for step_info in steps[step_name] -%}
            WHEN __link = '{{step_info.link}}' THEN '{{step_name}}'
        {% endfor %}
    {% endfor %}
    END) as __step
 from {{ ref('attr_' ~model_name~ '_prepare_with_qid') }}
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}
