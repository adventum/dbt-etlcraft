---
category: main
step: 2_staging
sub_step: 3_hash
doc_status:
---
# macro `hash`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "hash")
SORT doc_status
```


## Summary

The `hash` macro is designed to add hash columns to the data. In the future, these columns will be useful for data deduplication.

## Usage

The name of the dbt model (=the name of the sql file in the models folder) must match the template:
`hash_{pipeline_name}`.

For example, `hash_events`.

A macro is called inside this file:

```sql
{{ etlcraft.hash() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```
## Arguments

This macro accepts the following arguments:
1. `params` (default: none)
2.  `disable_incremental` (default: none)
3. `override_target_model_name` (default: none)
4. `metadata` (default: result of project_metadata() macro)
5. `date_from` (default: none)
6. `date_to` (default: none)
7. `limit0` (default: none)

## Functionality

## Example

A file in sql format in the models folder. File name: 
`hash_events`

File Contents:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```
## Notes

This is the fifth of the main macros.

**Перевод**

## Описание

Макрос `hash` предназначен для добавления к данным хэш-столбцов. В дальнейшем эти столбцы пригодятся для дедупликации данных.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`hash_{название_пайплайна}`.

Например, `hash_events`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.hash() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

1. `params` (по умолчанию: none)
2.  `disable_incremental` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `metadata` (по умолчанию: результат макроса project_metadata())
5. `date_from` (по умолчанию: none)
6. `date_to` (по умолчанию: none)
7. `limit0` (по умолчанию: none)

## Функциональность

Сначала макрос считает имя модели - либо из передаваемого аргумента (  
`override_target_model_name`), либо из имени файла (`this.name`). При использовании аргумента `override_target_model_name` макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Название модели, полученное тем или иным способом, разбивается на части по знаку нижнего подчёркивания. Например, название `hash_events` разобьётся на 2 части, из этих частей макрос возьмёт в работу:

- пайплайн - `pipeline_name` → events

Для пайплайна `registry` макрос возьмёт ещё линк.
Если пайплайн относится к `datestat` или `events`, то материализация будет инкрементальной:

```sql

{{ config(

    materialized='incremental',

    order_by=('__date', '__table_name'),

    incremental_strategy='delete+insert',

    unique_key=['__date', '__table_name'],

    on_schema_change='fail'

) }}
```
В других случаях - обычной:

```sql
{{ config(

    materialized='table',

    order_by=('__table_name'),

    on_schema_change='fail'

) }}
```
Если имя модели не соответствует шаблону - макрос выдаст  ошибку.

Далее макрос задаст паттерн, чтобы найти combine-таблицу нужного пайплайна.
Паттерн для пайплайна `registry`:

`'combine_' ~ pipeline_name ~'_'~ link_name`

Для других пайплайнов:

`'combine_' ~ pipeline_name`

Далее макрос будет работать с `metadata`.



  

{#- задаём список всех линков из metadata -#}

{%- set links = metadata['links'] -%} {# отбираем из metadata раздел links целиком #}

{%- set links_metadata_only_link_names = [] -%} {# отбираем из metadata только названия линков #}

{%- for link_name in links -%}

    {%- do links_metadata_only_link_names.append(link_name) -%}

{%- endfor -%}

  

{#- задаём списки, куда будем отбирать линки и сущности -#}

{%- set links_list = [] -%}

{%- set entities_list = [] -%}

{%- set registry_main_entities_list = [] -%}

{#- отбираем нужные линки и их сущности -#}

{%- if pipeline_name !='registry' -%} {# or pipeline_name !='periodstat' #}

{#- здесь берём поочередно каждый линк из списка и обращаемся с этим линком в раздел links из metadata -#}

{#- и получаем нужные данные по линку - его пайплайн, сущности и тд -#}

{%- for link_name in links_metadata_only_link_names -%}

    {%- set link_pipeline = links[link_name].get('pipeline') -%}

    {%- set datetime_field = links[link_name].get('datetime_field') -%}

    {%- set main_entities = links[link_name].get('main_entities') or [] -%}

    {%- set other_entities = links[link_name].get('other_entities') or [] -%}

    {%- set entities = main_entities + other_entities -%}

    {%- if link_pipeline == pipeline_name -%}

        {%- do links_list.append(link_name) -%}

        {%- for entity in entities -%}

            {%- do entities_list.append(entity) -%}

        {%- endfor -%}

    {%- endif -%}

    {%- for  main_entity in main_entities -%}

        {%- if link_pipeline == 'registry' -%} {#  or link_pipeline == 'periodstat' #}

            {%- do registry_main_entities_list.append(main_entity) -%}

        {%- endif -%}

    {%- endfor -%}

{%- endfor -%}

{%- endif -%}

  

{#- условие либо glue=yes, либо сущность из main_entities -#}

  

{#- находим сущности с glue=yes -#}

{#- задаём список всех сущностей метадаты -#}

{%- set metadata_entities = metadata['entities'] -%}

{#- задаём список для сущностей, у которых найдём glue='yes' -#}

{%- set metadata_entities_list = [] -%}

{#- отбираем нужные сущности -#}

{%- for entity_name in metadata_entities  -%}

    {%- set entity_glue = metadata_entities[entity_name].get('glue') -%}

    {%- if entity_glue -%}  {# по факту читается как True, поэтому пишем просто if #}

        {%- do metadata_entities_list.append(entity_name) -%}

    {%- endif -%}

{%- endfor -%}

  

{#- делаем полученный список сущностей уникальным -#}

{%- set unique_entities_list = entities_list|unique|list -%}

  
  

{#- из уникального списка сущностей отбираем те, которые

    либо есть в списке сущностей glue='yes', либо есть в разделе registries -#}

{%- set final_entities_list = [] -%}

{%- for unique_entity in unique_entities_list  -%}

    {%- if unique_entity in registry_main_entities_list or unique_entity in metadata_entities_list -%}

        {%- do final_entities_list.append(unique_entity) -%}

    {%- endif -%}

{%- endfor -%}

  

{#- ********************************************* работа с metadata для пайплайна registry *************************************** -#}

  

{#- для моделей пайплайна registry отбираем линки и сущности отдельно,

чтобы выводить модели по-отдельности для каждого источника данных -#}

{%- if pipeline_name == 'registry'-%} {#  or pipeline_name == 'periodstat' #}

  

{%- set links_list = [] -%}

{%- set links = metadata['links'] -%}

{%- for link in links  -%}

  {%- set lower_link_name = link|lower -%} {# приводим к нижнему регистру  #}

  {%- if lower_link_name == link_name -%} {# сравниваем линк в нижнем регистре с линком из названия модели #}

    {%- do links_list.append(link) -%} {# если они совпадают, отбираем этот линк #}

  {%- endif -%}

{%- endfor -%}

  

{#- для этого линка отбираем связанные с ним сущности -#}

{%- set final_entities_list = [] -%}

{%- for link_name in links_list  -%}

    {%- set main_entities = links[link_name].get('main_entities') or [] -%}

    {%- set other_entities = links[link_name].get('other_entities') or [] -%}

    {%- set entities = main_entities + other_entities -%}

    {%- for entity in entities -%}

        {%- do final_entities_list.append(entity) -%}

    {%- endfor -%}

{%- endfor -%}

{#- делаем полученные списки уникальными -#}

{%- set links_list = links_list|unique|list -%}

{%- set final_entities_list = final_entities_list|unique|list -%}

{%- endif -%}

  
  

{#- **************************************************** SQL-запрос ********************************************************* -#}

  

SELECT *,

  assumeNotNull(CASE

{%- for link in links_list %}

    {%- set link_hash = link ~ 'Hash' %}  

    WHEN __link = '{{link}}'

    THEN {{link_hash}}

{% endfor %}

    END) as __id

  , assumeNotNull(CASE

{%- for link_name in links -%}

    {%- set datetime_field = links[link_name].get('datetime_field') -%}

    {%- set link_pipeline = links[link_name].get('pipeline') -%}

    {%- if link_pipeline == pipeline_name %}

    WHEN __link = '{{link_name}}'

    {% if datetime_field -%} {# если поле datetime_field из метадаты есть #}

    THEN toDateTime({{datetime_field}}) {# то приводим его к формату даты #}

    {% else -%} {# если такого поля в метадате нет #}

    THEN toDateTime({{ etlcraft.zero_date() }}) {# то приводим дефолтное поле к формату даты через свой макрос, либо просто меняем эту строку на THEN null #}

    {% endif -%}{%- endif -%} {% endfor -%}

    END) AS __datetime

FROM (

  

SELECT *,

{% for link in links_list %}

{#- добавляем хэши для отобранных линков -#}

    {{ etlcraft.link_hash(link, metadata) }}{% if not loop.last %},{% endif -%}  {# ставим запятые везде, кроме последнего элемента цикла #}

{% endfor %}

{% if final_entities_list and links_list %},{%- endif -%} {# если есть сущности, ставим перед их началом запятую #}

{% for entity in final_entities_list %}

{#- добавляем хэши для отобранных сущностей -#}

    {{ etlcraft.entity_hash(entity, metadata) }}{% if not loop.last %},{% endif -%} {# ставим запятые везде, кроме последнего элемента цикла #}

{% endfor -%}

FROM {{ ref(table_pattern) }}

WHERE

{% for link in links_list %}

    {{ link ~ 'Hash' != ''}}{% if not loop.last %} AND {% endif -%}

{% endfor %}

)

{% if limit0 %}

LIMIT 0

{%- endif -%}

  

-- SETTINGS short_circuit_function_evaluation=force_enable

  

{% endmacro %}

## Пример

Файл в формате sql в папке models. Название файла `hash_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```

## Примечания

Это пятый из основных макросов.