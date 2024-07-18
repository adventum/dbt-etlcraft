{%- macro attr_join_to_attr_prepare_with_qid(
  params = none,
  override_target_metadata=none,
  features_list=none,
  funnel_name=none,
  limit0=none
  ) -%}

{# 
    Извлечение метаданных для определения типов моделей и их приоритетов.
#}
{%- set metadata = fromyaml(etlcraft.metadata(override_target_metadata, features_list)) -%}
{%- set funnels = metadata['funnels'] -%}
{%- set attribution_models = metadata['attribution_models'] -%}
{%- set model_list = funnels[funnel_name].models -%}
{%- set step_name_list = funnels[funnel_name].steps -%}
{%- set steps = metadata['steps'] -%}

{# 
    Создание словаря для хранения информации о моделях.
    Каждая модель представлена как ключ, а ее тип как значения.
#}
{%- set model_info = {} -%}
{% for model in model_list %}
    {%- set _ = model_info.update({attribution_models[model].type: attribution_models[model].priorities}) -%}
{% endfor %}

{# 
    Настройка материализации данных.
    order_by=('qid', '__period_number', '__datetime', '__priority', '__id') определяет порядок сортировки данных по идентификатору группы, номеру периода, дате, приоритету и идентификатору.
#}
{{
    config(
        materialized='table',
        order_by=('qid', '__period_number', '__datetime', '__priority', '__id')
    )
}}

{# 
    Объединение результатов двух запросов: attr_prepare_with_qid и attr_create_missed_steps.
#}
select 
    y.__period_number as __period_number, 
    y.__if_missed as __if_missed, 
    y.__priority as __priority, 
    y.__step as __step,
    x.*EXCEPT(adSourceDirty),

{# 
    Вычисление ранга для каждой модели в зависимости от ее приоритета.
#}
{% for model_type, priorities in model_info.items() %}
    CASE
    {% for priority in priorities %}
        {%- set counter = loop.index -%}
        WHEN {{ priority }} THEN {{ counter }}
    {% endfor %}
    ELSE 0
    END as {{ '__'~ model_type ~ '_rank' }},
{% endfor %}

{# 
    Определение adSourceDirty для каждого события в зависимости от его приоритета и флага пропущенного шага.
#}
CASE
{% for step_name in step_name_list %}
    {%- set counter = loop.index -%}
    {% for step_info in steps[step_name] %}
         WHEN  __if_missed and __priority = {{ counter }} 
         THEN '{{step_info.if_missed}}'
    {% endfor %}
{% endfor %}
ELSE adSourceDirty
END as adSourceDirty

from {{ ref('attr_' ~funnel_name~ '_prepare_with_qid') }} AS x
join {{ ref('attr_' ~funnel_name~ '_create_missed_steps') }} AS y
    using (qid, __datetime, __link, __id)
{% if limit0 %}
LIMIT 0
{%- endif -%}

{% endmacro %}
