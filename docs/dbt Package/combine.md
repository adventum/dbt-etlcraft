---
category: main
step: 2_staging
sub_step: 2_combine
doc_status: ready
language: rus
main_number: "04"
---
# macro `combine`

## Список используемых вспомогательных макросов

| Name                       | Category  | In Main Macro           | Doc Status |
| -------------------------- | --------- | ----------------------- | ---------- |
| [[custom_union_relations]] | auxiliary | combine, create_dataset | ready      |
| [[get_relations_by_re]]    | auxiliary | normalize, combine      | ready      |

## Описание

Макрос `combine` предназначен для объединения данных по каждому пайплайну.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`combine_{название_пайплайна}`.

Например, `combine_events`.

Внутри этого файла вызывается макрос:

```sql
{{ datacraft.combine() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ datacraft.combine() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

1. `params` (по умолчанию: none)
2.  `disable_incremental` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `date_from` (по умолчанию: none)
5. `date_to` (по умолчанию: none)
6. `limit0` (по умолчанию: none)
## Функциональность

Сначала макрос считает имя модели - либо из передаваемого аргумента (
`override_target_model_name`), либо из имени файла (`this.name`). При использовании аргумента `override_target_model_name` макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Название модели, полученное тем или иным способом, разбивается на части по знаку нижнего подчёркивания. Например, название `combine_events` разобьётся на 2 части, из этих частей макрос возьмёт в работу:
- пайплайн - `pipeline_name` → events

Модели шага `combine` могут иметь названия из 2 или 3 частей, вторая часть всегда пайплайн.

Если модель относится к пайплайну `registry`, то у неё ещё есть линк. Например, для модели `combine_registry_appprofilematching` есть:
- линк - `link_name` → appprofilematching

Если имя модели не соответствует шаблону - макрос выдаст ошибку.

Далее макрос будет искать по паттерну соответствующие ему таблицы из предыдущего шага (`join`).
 
 Паттерн для пайплайна `registry`:

`'join' ~ '_[^_]+_' ~ pipeline_name ~ '_' ~ link_name`

для всех остальных данных паттерн:

`'join' ~ '_[^_]+_' ~ pipeline_name`

Макрос находит все соответствующие таблицы благодаря работе другого макроса - [[get_relations_by_re]].

Если никакие данные не будут найдены, макрос выдаст ошибку.

Далее полученные данные автоматически объединятся (`UNION ALL`) при помощи макроса [[custom_union_relations]]. Таким образом сформируется таблица-источник - `source_table`.

Если данные относятся к пайплайнам `datestat` или `events`, то материализация таблицы будет инкрементальной:

```sql
  {{ config(

      materialized='incremental',

      order_by=('__date', '__table_name'),

      incremental_strategy='delete+insert',

      unique_key=['__date', '__table_name'],

      on_schema_change='fail'

  ) }}
```

Для других пайплайнов материализация будет другой:

```sql
  {{ config(

      materialized='table',

      order_by=('__table_name'),

      on_schema_change='fail'

  ) }}
```
В автоматически генерируемом SQL-запросе в блоке SELECT будут выбраны все столбцы из ранее созданной `source_table`. Столбец `table_name` будет обёрнут в `LowCardinality` для улучшения производительности.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

## Пример

Файл в формате sql в папке models. Название файла: 
`combine_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ datacraft.combine() }}
```

## Примечания

Это четвёртый из основных макросов.