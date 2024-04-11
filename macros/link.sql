{%- macro link() %}

{% set metadata = fromyaml(etlcraft.metadata()) %}

{#- задаём части имени - чтобы выделить имя нужной hash-таблицы -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set hash_raw_name = model_name_parts[1:] -%}
{%- set hash_name = '_'.join(hash_raw_name) -%}
{% set source_model_name = 'hash_' ~ hash_name %}

{#- задаём пустой список: сюда будем добавлять колонки, по которым будем делать GROUP BY -#}
{% set group_by_fields = [] %}

{#- для каждой колонки таблицы, на которую будем ссылаться -#}
SELECT {% for c in adapter.get_columns_in_relation(load_relation(ref(source_model_name))) -%}
{#- если тип данных колонки не числовой - добавляем её в список для будущей группировки -#}
{% if 'String' in c.data_type or 'LowCardinality' in c.data_type or 'Date' in c.data_type or 'DateTime' in c.data_type %}{{ c.name }}
{%- do group_by_fields.append(c.name)  -%}
{#- а если тип данных колонки числовой - суммируем данные по ней -#}
{%- elif 'Int' in c.data_type or 'Float' in c.data_type or 'Num' in c.data_type %}SUM({{ c.name }}) AS {{ c.name }}
{#- а для остальных (т.е. колонок не числового типа данных) - делаем MAX - просто чтобы избежать дублей -#}
{%- else %} MAX({{ c.name }}) AS {{ c.name }}
{#- после каждой строки кроме последней расставляем запятые, чтобы сгенерировался читаемый запрос -#}
{%- endif %}{% if not loop.last %},{% endif %}{% endfor %} 
FROM {{ ref(source_model_name) }}
GROUP BY {{ group_by_fields | join(', ') }}


{% endmacro %}