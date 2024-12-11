{%- macro attr_model(
  params = none,
  funnel_name=none,
  limit0=none,
  metadata=project_metadata()
  ) -%}


{%- set funnels = metadata['funnels'] -%}
{%- set attribution_models = metadata['attribution_models'] -%}
{%- set model_list = funnels[funnel_name].models -%}

{% set model_type = attributions[model_name]['model_type'] %}
{{ log("model_type:"~model_type, true) }}
{% set fields = attributions[model_name]['attributable_parameters'] %}
{{ log("fields:"~fields, true) }}

{# 
    Настройка материализации данных.
    order_by=('qid', '__datetime', '__id') 
    определяет порядок сортировки данных по идентификатору группы, номеру периода, дате, приоритету и идентификатору.
#}

{{
    config(
        materialized='table',
        order_by = ('qid', '__datetime', '__id')
    )
}}

{# 
    Определение основных столбцов, необходимых для объединения данных моделей.
#}
with
max_click_rank as (

    select
        *
        ,max({{'__'~ model_type ~ '_rank' }}) over(partition by qid, __period_number order by __datetime, __priority, __id) as {{'__max_' ~ model_type ~ '_rank' }}
     from {{ ref('attr_' ~model_name~ '_join_to_attr_prepare_with_qid') }}

),

{# 
    Подсчет числа целевых моделей (моделей с максимальным приоритетом) для каждой группы и периода.
#}
target_count as (

    select
        *
         ,{{'__'~ model_type ~ '_rank' }} = {{'__max_' ~ model_type ~ '_rank' }} as  {{'__' ~ model_type ~ '__rank_condition' }}
         ,sum(case when {{'__' ~ model_type ~ '__rank_condition' }} then 1 else 0 end) over(partition by qid, __period_number order by __datetime, __priority, __id) as {{'__' ~ model_type ~ '__target_count' }}
    from max_click_rank
)

{# 
    Выборка данных и расчет значений для каждой модели.
#}
SELECT 
    qid, __datetime, __id, __priority,`__if_missed`,__link,__period_number
    {% if model_type == 'last_click' %}
        {# 
            Расчет значений для последнего клика.
        #}
        {% for field in fields %}
            ,first_value({{field}}) over(partition by qid, __period_number, {{'__' ~ model_type ~ '__target_count' }}  order by  __datetime, __priority, __id) as {{'__' ~  model_name ~'_'~ model_type ~'_'~ field}}
        {% endfor %}
    {% elif model_type == 'first_click' %}
        {# 
            Расчет значений для первого клика.
        #}
        {% for field in fields %}
            ,first_value({{field}}) over(partition by qid, __period_number order by {{'__' ~ model_type ~ '_rank' }} desc,__datetime, __priority, __id) as {{'__' ~  model_name ~'_'~ model_type ~ '_'~ field}}
        {% endfor %}
    {%  endif %} 
FROM target_count
{% if limit0 %}
LIMIT 0
{%- endif -%}

{%- endmacro %}
