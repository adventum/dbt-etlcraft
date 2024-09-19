---
category: main
step: 5_full
sub_step: 
doc_status: empty_template
language: rus
---
# macro `full`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "full")
SORT doc_status
```

## Описание

Макрос `full` предназначен для объединения данных пайплайна с `registry`-таблицами. В зависимости от пайплайна поведение макроса меняется.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`full_{название_пайплайна}`.

Например, `full_events`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.full() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('graph_qid') }}

-- depends_on: {{ ref('link_events') }}

-- depends_on: {{ ref('link_registry_appprofilematching') }}

-- depends_on: {{ ref('link_registry_utmhashregistry') }}

{{ etlcraft.full() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:
 
1. `params` (по умолчанию: none)
2.  `disable_incremental` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `date_from` (по умолчанию: none)
5. `date_to` (по умолчанию: none)
6. `limit0` (по умолчанию: none)
7. `metadata` (по умолчанию: результат макроса `project_metadata()`)
## Функциональность

Сначала макрос считает имя модели - либо из передаваемого аргумента (  
`override_target_model_name`), либо из имени файла (`this.name`). При использовании аргумента `override_target_model_name` макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Название модели, полученное тем или иным способом, разбивается на части по знаку нижнего подчёркивания. Например, название `full_events` разобьётся на 2 части, из этих частей макрос возьмёт в работу:

- пайплайн - `pipeline_name` → events
  
Для каждого пайплайна в макросе задаётся своя материализация и своё поведение в начале, до присоединения registry-таблиц:

- для пайплайна `events`- материализация `table` и соединение данных из таблиц `link_events` + `graph_qid` + имеющихся таблиц пайплайна `registry`

- для пайплайна `datestat` - материализация `incremental` и соединение данных из таблицы `link_datestat` + имеющихся таблиц пайплайна `registry`

- для пайплайна `periodstat` - материализация `incremental` и разбиение метрик по дням + добавление имеющихся таблиц пайплайна `registry`


  

{#- ************************************* отбор возможных и существующих таблиц registry ************************************* -#}

  

{#- создаём список возможных таблиц registry - это нужно для всех пайплайнов -#}

{%- set links_list = [] -%}

{%- set registry_possible_tables = [] -%}

{%- set links = metadata['links'] -%}

{%- for link_name in links  -%}

  {%- set lower_link_name = link_name|lower -%} {# приводим к нижнему регистру  #}

  {%- do links_list.append(lower_link_name) -%}

  {%- set table_name = 'link_registry_' ~ lower_link_name -%} {# создаём вариант имени registry-таблицы #}

  {%- do registry_possible_tables.append(table_name) -%}

{%- endfor -%}

  

{#- отбираем те из них, которые существуют -#}

{%- set registry_existing_tables = [] -%}

{%- for table_ in registry_possible_tables -%}

    {%- set table_exists = etlcraft.clickhouse__check_table_exists(source_table=table_, database=this.schema) -%}

    {%- if table_exists == 1 -%}

    {%- do registry_existing_tables.append(table_) -%}

    {%- endif -%}

{%- endfor -%}

  

{#- *********************************  для каждого пайплайна создаём основу запроса - CTE t0    ********************************** -#}

  

{#- начинаем перебор пайплайнов с помощью if -#}

{%- if pipeline_name =='events' -%} {# для пайплайна events основа это link_events + graph_qid #}

WITH t0 AS (

SELECT * FROM {{ ref('link_events') }}

LEFT JOIN {{ ref('graph_qid') }} USING (__id, __link, __datetime)

)

  

{%- elif pipeline_name =='datestat' -%}  {# для пайплайна datestat это link_datestat #}

WITH t0 AS (

SELECT * FROM {{ ref('link_datestat') }}

)

  

{%- elif pipeline_name =='periodstat' -%}  {# для пайплайна periodstat берём данные из link_periodstat и разбиваем их по дням #}

{#- для этого понадобится произвести дополнительные действия -#}

{#- задаём наименования числовых типов данных -#}

{%- set numeric_types = ['UInt8', 'UInt16', 'UInt32', 'UInt64', 'UInt256',

                        'Int8', 'Int16', 'Int32', 'Int64', 'Int128', 'Int256',

                        'Float8', 'Float16','Float32', 'Float64','Float128', 'Float256','Num'] -%}

{%- set columns_numeric = [] -%} {# сюда отберём колонки с числовыми типами данных #}

{%- set columns_not_numeric = [] -%} {# сюда - с нечисловыми #}

{%- set source_columns = adapter.get_columns_in_relation(load_relation(ref('link_periodstat'))) -%} {# берём колонки #}

  

{%- for c in source_columns -%} {# для каждой колонки проверяем её тип данных и отбираем её в тот или иной заготовленный список #}

    {%- if c.data_type in numeric_types -%}

        {%- do columns_numeric.append(c.name)  -%}

    {%- else -%}

        {%- do columns_not_numeric.append(c.name)  -%}

    {%- endif -%}

{%- endfor -%}

  

{# будем разбивать период на дни - например была одна строка с periodStart='2024-01-01' и periodEnd='2024-01-31' и

и значением cost за весь период, например, 31000 #}

{# а мы сделаем 31 строку - по одной на каждый день этого периода и значением cost_per_day равным 1000 #}

WITH unnest_dates AS (

SELECT *, {# берём все данные, какие были в таблице и добавляем к ним каждый день периода #}

    dateAdd(periodStart, arrayJoin(range( 0, 1 + toUInt16(date_diff('day', periodStart, periodEnd))))) AS period_date

    , COUNT(*) OVER(PARTITION BY

{% for c in columns_not_numeric -%}{{c}}

{% if not loop.last %},{% endif %}

{% endfor %}

    ) AS divide_by_days {# здесь мы вычисляем кол-во дней, на которое надо будем в дальнейшем делить метрики #}

FROM {{ ref('link_periodstat') }}

)

, t0 AS (

SELECT period_date, {# отбираем все даты периода  #}

{% for column in columns_not_numeric -%}{{column}}, {# не числовые колонки - такими какими они и были #}

{% endfor %}   {# а значения в числовых колонках делим на количество дней в периоде #}

{% for column in columns_numeric -%}{{column}}/divide_by_days AS {{column}}_per_day {# и таким образом получаем новые столбцы #}

{% if not loop.last %},{% endif %}   {# например вместо cost будет cost_per_day #}

{% endfor %}

FROM unnest_dates

)

{%- endif -%} {# заканчиваем перебор пайплайнов с помощью if #}

  

{#- ******************************  для каждого пайплайна отбор полей pipeline_columns   ********************************** -#}

  

{#- здесь нет условия if, но, поскольку при вызове моделей у каждой свой pipeline_name, значения будут разными -#}

{%- set pipeline_columns = [] -%} {# сюда будем отбирать колонки с сущностями каждого пайплайна #}

{%- set links_list = [] -%}

{%- set links = metadata['links'] -%} {# отбираем из metadata раздел links целиком #}  

    {%- for link in links  -%}

      {%- do links_list.append(link) -%}

    {%- endfor -%}

  

{#- здесь берём поочередно каждый линк из списка и обращаемся с этим линком в раздел links из metadata -#}

{#- и получаем нужные данные по линку - его пайплайн, сущности и тд -#}

{%- for link_name in links_list -%}

    {%- set pipeline = links[link_name].get('pipeline') or [] -%}

    {%- if pipeline == pipeline_name -%}

        {%- set main_entities = links[link_name].get('main_entities') or [] -%}

        {%- set other_entities = links[link_name].get('other_entities') or [] -%}

        {%- set entities = main_entities + other_entities -%}

        {%- for entity in entities -%}

            {%- do pipeline_columns.append(entity ~ 'Hash') -%}

        {%- endfor -%}

    {%- endif -%}

{%- endfor -%}

{#- делаем полученный список уникальным -#}

{%- set pipeline_columns = pipeline_columns|unique|list -%}

  

{#- SELECT {{ pipeline_columns }} например для events выводит

SELECT ['AccountHash', 'AppMetricaDeviceHash', 'MobileAdsIdHash', 'CrmUserHash', 'OsNameHash', 'CityHash',

'AdSourceHash', 'UtmParamsHash', 'UtmHashHash', 'TransactionHash', 'PromoCodeHash',

'AppSessionHash', 'VisitHash', 'YmClientHash'] -#}

  

{#-  ********************************* цикл для последовательных джойнов таблиц registry  **************************************  -#}

  

{#- теперь основу - т.е. CTE t0 для каждого пайплайна - будем поочерёдно обогащать данными из registry-таблиц,

                                                    для этого запускаем цикл for -#}

{%- for r in registry_existing_tables -%}  

    {%- set fields_list = [] -%} {# создаём список, куда будем отбирать поля для будущего USING(...) #}

    {%- set links_list = [] -%}

    {%- set links = metadata['links'] -%}

    {%- for link in links  -%}

      {%- if link|lower == r.split('_')[-1]  -%} {# приводим к нижнему регистру и сравниваем с линком из названия модели #}

        {%- do links_list.append(link) -%} {# если они совпадают, отбираем этот линк #}

      {%- endif -%}

    {%- endfor -%}

    {#- для этого линка отбираем связанные с ним сущности -#}

    {%- for link_name in links_list  -%}

        {%- set main_entities = links[link_name].get('main_entities') or [] -%}

                                  {#-  {%- set other_entities = links[link_name].get('other_entities') or [] -%} -#}

                                  {#-  {%- set entities = main_entities + other_entities -%} -#}

        {%- for entity in main_entities -%}

            {%- do fields_list.append(entity ~ 'Hash') -%} {# сохраняем имя поля с этой сущностью для будущего USING(...) #}

        {%- endfor -%}

    {%- endfor -%}

    {#- делаем полученный список уникальным -#}

    {%- set fields_list = fields_list|unique|list -%}

  

    {#- отбираем только те значения fields_list, которые есть в pipeline_columns -#}

    {%- set existing_fields_list = [] -%}

    {%- for f in fields_list -%}

        {%- if f in pipeline_columns|unique|list -%}

            {%- do existing_fields_list.append(f) -%}

        {%- endif -%}

    {%- endfor -%}

  

    {# здесь проходим циклом - создаём t1, который обогащает t0 одной таблицей registry,

    на следующем обороте t2 обогащает t1 ещё одной таблицей registry и тд.

    Для каждого раза у нас автоматически подставляются и таблица registry, и её хэш-поля в USING(...) для верного джойна #}

  

{%- if existing_fields_list|length >= 1 -%} {# если у нас есть общие поля, по к-ым можно сделать USING(...), то мы делаем джойн #}

, t{{loop.index}} AS (

SELECT t{{loop.index-1}}.*, {{r}}.*EXCEPT(__emitted_at, __table_name, __id, __datetime, __link)

FROM t{{loop.index-1}}

LEFT JOIN {{r}} USING ({% for f in existing_fields_list %}{{f}}{% if not loop.last %},{% endif -%}{% endfor %})

)

{%- else -%}   {# если общих полей для USING(...) нет, то мы этот шаг делаем без джойна, просто как SELECT * FROM предыдущий шаг #}

, t{{loop.index}} AS (

SELECT *

FROM t{{loop.index-1}}

)

{%- endif -%}

  

{%- endfor %} {# после завершения цикла берём t<кол-во имевшихся registry-таблиц> - т.е. из последнего CTE #}

SELECT COLUMNS('^[^.]+$') FROM t{{registry_existing_tables|length}}

{% if limit0 %}

LIMIT 0

{%- endif -%}

  

{#- SELECT COLUMNS('^[a-z|_][^2]')  помогало отбирать на лету все колонки по regexp - например все колонки кроме t2.<...>  -#}

{#- SELECT COLUMNS('^[a-zA-z|_|0-9]*$') FROM отобрать все колонки, кроме тех, где есть точка

то есть от начала до конца есть только буквы, цифры, нижние подчеркивания -#}

  

{% endmacro %}

## Пример

Файл в формате sql в папке models. Название файла `full_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('graph_qid') }}

-- depends_on: {{ ref('link_events') }}

-- depends_on: {{ ref('link_registry_appprofilematching') }}

-- depends_on: {{ ref('link_registry_utmhashregistry') }}

{{ etlcraft.full() }}
```

## Примечания

Это восьмой из основных макросов.