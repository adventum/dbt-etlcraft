---
category: sub_main
step: 6_attribution
sub_step: 1_prepare
in_main_macro: attr
doc_status: empty_template
---
# macro `attr_prepare_with_qid`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "attr_prepare_with_qid")
SORT doc_status
```
## Описание

Это первый шаг макроса `attr`. Этот макрос подготавливает данные с уникальными идентификаторами узлов, необходимыми для атрибуции. Он использует данные из других источников и создает таблицу с уникальными идентификаторами узлов для каждого события.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params = none,
  funnel_name=none,
  limit0=none
```
## Функциональность

## Пример

Файл в формате sql в папке models. Название файла `attr_myfirstfunnel_prepare_with_qid`

Содержимое файла:
```sql
-- depends_on: {{ ref('full_events') }}

-- depends_on: {{ ref('graph_qid') }}

{{ etlcraft.attr() }}
```
