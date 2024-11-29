---
category: main
step: 7_dataset
sub_step: 
doc_status: ready
language: rus
main_number: "10"
---
# macro `create_dataset`

## Список используемых вспомогательных макросов

| Name                       | Category  | In Main Macro           | Doc Status |
| -------------------------- | --------- | ----------------------- | ---------- |
| [[custom_union_relations]] | auxiliary | combine, create_dataset | ready      |

## Описание

Макрос `create_dataset` предназначен для создания финальной таблицы с учётом пожеланий клиента.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) для данного макроса не должно соответствовать какому-либо строгому шаблону. Модель можно назвать свободным образом по желанию клиента, но, соблюдая стиль datacraft, можно рекомендовать название,

например, `dataset_event_table`.

Внутри этого файла вызывается макрос:

```sql
{{ datacraft.create_dataset() }}
```
Особенность этого макроса в том, что он не опирается на название файла, в котором он вызывается. Но взамен он требует передачи информации от клиента в аргументы `funnel` и `conditions`.

Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('full_datestat') }}

-- depends_on: {{ ref('attr_myfirstfunnel_final_table') }}

{{ datacraft.create_dataset(

    funnel = 'myfirstfunnel',

    conditions =

    [{
    'pipeline':'datestat',
    'source': 'yd',
    'account': 'accountid',
    'preset': 'default'
    },

    {
    'pipeline': 'events',
    'source': 'appmetrica',
    'account': 'accountid',
    'preset': 'default'
    },

    {
    'pipeline':'events',
    'source': 'ym',
    'account': 'accountid',
    'preset': 'default'
    }
     ]

) }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

1. `funnel` (по умолчанию: none)
2. `conditions` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `limit0` (по умолчанию: none)
## Функциональность

Этот макрос работает на основе содержимого, которое передано в аргументы `funnel` и `conditions`.

В отличие от аргумента `funnel`, который может быть пропущен, аргумент `conditions` передаёт критически важную для построения таблицы информацию.

Содержимое аргумента `conditions` состоит из списка словарей. В словарях содержатся значения пайплайна, источника, аккаунта и пресета, которые нужны клиенту. 

Например, один из словарей такого списка может выглядеть так:

```sql
{
    'pipeline':'datestat',
    'source': 'yd',
    'account': 'accountid',
    'preset': 'default'
}
```
В начале работы макроса создаётся переменная `patterns`, в которую будут собираться паттерны названий таблиц, которые нужны для построения итоговой таблицы.

Для каждого словаря, переданного в список `conditions`, макрос смотрит значение пайплайна. В зависимости от пайплайна и значения аргумента `funnel` макрос по-разному задаёт паттерн таблицы-источника:

- если пайплайн - `events` и значение воронки задано, то паттерном искомой таблицы будет:
	`'attr_' ~ funnel  ~ '_final_table'`

- если пайплайн - `events`, но значение воронки не задано, то паттерном искомой таблицы будет
  `'full_' ~ condition.pipeline`

 - для других пайплайнов паттерном будет:

     `'full_' ~ condition.pipeline`

Далее для уникального списка паттернов таблиц будут отбираться их связи - `relations`. Таким образом получится список `relations`, который будет передан в дополнительный макрос [[custom_union_relations]].

Так сформируется таблица-источник - `source_table`, которая будет фигурировать в итоговом SQL-запросе в блоке `FROM`.

Материализация финальной таблицы - ‘table’. Полностью `config` выглядит так:
```sql
{{

    config(

        materialized = 'table',

        order_by = ('__datetime')

    )

}}
```
  Далее в макросе будут задаваться переменные, которые будут использоваться в итоговом SQL-запросе в блоке `WHERE`, это:
  - `source_field`
  - `account_field`
  - `preset_field`

Значения для этих переменных берутся из поля `__table_name` - это поле, где указаны “сырые” данные.

Например, “сырые” данные могут называться так:
`datacraft_clientname_raw__stream_appmetrica_default_accountid_events`

Отсюда макрос возьмёт:
- `source_field` как 6-ю часть этого названия (`appmetrica`)
- `account_field` как 8-ю часть (`accountid`)
- `preset_field` как 7-ю часть (`default`)

Чтобы макрос отрабатывал успешно, в вызове модели: 
- `account` должен совпадать с `account_field` 
- `source` должен совпадать с `source_field` 
- `preset` должен совпадать с `preset_field` 

То есть то, что передаётся в аргумент `conditions`, должно иметь отражение в реально существующих данных.

В результате работы макроса получается SQL-запрос для каждого condition, указанного пользователем, с нужными с условиями:

```sql
WITH final_query AS (

{% for condition in conditions %}

  {% if loop.last %}

    SELECT * FROM {{ source_table }}

    WHERE

    {{source_field}} = '{{condition.source}}'

    and

    {{account_field}} = '{{condition.account}}'

    and

    {{preset_field}} = '{{condition.preset}}'

  {% else %}

    SELECT * FROM {{ source_table }}

    WHERE

    {{source_field}} = '{{condition.source}}'

    and

    {{account_field}} = '{{condition.account}}'

    and

    {{preset_field}} = '{{condition.preset}}'

    UNION ALL

  {%- endif -%}  

{%- endfor -%}

)

SELECT *

FROM final_query
```
Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

## Пример

Файл в формате sql в папке models. Название файла в свободном формате.

Содержимое файла:
```sql
-- depends_on: {{ ref('full_datestat') }}

-- depends_on: {{ ref('attr_myfirstfunnel_final_table') }}

{{ datacraft.create_dataset(

    funnel = 'myfirstfunnel',

    conditions =

    [{

    'pipeline':'datestat',
    'source': 'yd',
    'account': 'accountid',
    'preset': 'default'
    },

    {
    'pipeline': 'events',
    'source': 'appmetrica',
    'account': 'accountid',
    'preset': 'default'
    },

    {

    'pipeline':'events',
    'source': 'ym',
    'account': 'accountid',
    'preset': 'default'
    }
     ]

) }}
```

## Примечания

Это десятый (финальный) из основных макросов.