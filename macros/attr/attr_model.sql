{%- macro attr_model(
  params = none,
  override_target_metadata=none,
  funnel_name=none
  ) -%}

{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set funnels = metadata['funnels'] -%}
{%- set attribution_models = metadata['attribution_models'] -%}
{%- set model_list = funnels[funnel_name].models -%}

{# 
    Создание словаря для хранения информации о полях каждой модели.
    Каждая модель представлена как ключ, а ее поля как значения.
#}
{%- set model_info = {} -%}
{% for model in model_list %}
    {%- set _ = model_info.update({attribution_models[model].type: attribution_models[model].fields}) -%}
{% endfor %}

{# 
    Настройка материализации данных.
    order_by=('qid', '__datetime', '__id') определяет порядок сортировки данных по идентификатору группы, номеру периода, дате, приоритету и идентификатору.
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
max_last_click_rank as (

    select
        *
{% for model_type in model_info %}
        ,max({{'__'~ model_type ~ '_rank' }}) over(partition by qid, __period_number order by __datetime, __priority, __id) as {{'__max_' ~ model_type ~ '_rank' }}
{%  endfor %}
     from {{ ref('attr_' ~funnel_name~ '_join_to_attr_prepare_with_qid') }}

),

{# 
    Подсчет числа целевых моделей (моделей с максимальным приоритетом) для каждой группы и периода.
#}
target_count as (

    select
        *
{% for model_type in model_info %}
         ,{{'__'~ model_type ~ '_rank' }} = {{'__max_' ~ model_type ~ '_rank' }} as  {{'__' ~ model_type ~ '__rank_condition' }}
         ,sum(case when {{'__' ~ model_type ~ '__rank_condition' }} then 1 else 0 end) over(partition by qid, __period_number order by __datetime, __priority, __id) as {{'__' ~ model_type ~ '__target_count' }} 
{%  endfor %}
    from max_last_click_rank
)

{# 
    Выборка данных и расчет значений для каждой модели.
#}
SELECT 
    qid, __datetime, __id, __priority,`__if_missed`,__link,__period_number,__step

{% for model_type, fields in model_info.items() %}
    {% if model_type == 'last_click' %}
        {# 
            Расчет значений для последнего клика.
        #}
        {% for field in fields %}
            ,first_value({{field}}) over(partition by qid, __period_number, {{'__' ~ model_type ~ '__target_count' }}  order by  __datetime, __priority, __id) as {{'__' ~  funnel_name ~'_'~ model_type ~'_'~ field}}
        {% endfor %}
    {% elif model_type == 'first_click' %}
        {# 
            Расчет значений для первого клика.
        #}
        {% for field in fields %}
            ,first_value({{field}}) over(partition by qid, __period_number order by {{'__' ~ model_type ~ '_rank' }} desc,__datetime, __priority, __id) as {{'__' ~  funnel_name ~'_'~ model_type ~ '_'~ field}}
        {% endfor %}
    {%  endif %} 
{% endfor %}

 FROM target_count

{%- endmacro %}
