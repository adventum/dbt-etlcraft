---
category: sub_main
step: 6_attribution
sub_step: 1_prepare
in_main_macro: attr
doc_status: ready
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

Сначала в макросе задаётся настройка материализации данных: устанавливается порядок сортировки данных по идентификатору группы, дате, ссылке и идентификатору.

Далее происходит выборка данных из таблицы `full_events` с добавлением идентификаторов группы из ранее созданной таблицы `graph_qid`.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `attr_myfirstfunnel_prepare_with_qid`

Содержимое файла:
```sql
-- depends_on: {{ ref('full_events') }}

-- depends_on: {{ ref('graph_qid') }}

{{ etlcraft.attr() }}
```