---
category: sub_main
step: 6_attribution
sub_step: 3_add_row_number
in_main_macro: attr
doc_status: ready
---
# macro `attr_add_row_number`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "attr_add_row_number")
SORT doc_status
```
## Описание

Это третий шаг макроса `attr`. Этот макрос добавляет номер строки к данным для атрибуции. Это нужно для последующего анализа и обработки данных.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params = none,
  funnel_name=none,
  limit0=none
```
## Функциональность

Сн6ачале в макросе происходит настройка материализации данных: устанавливается порядок сортировки данных по идентификатору группы, дате, ссылке и идентификатору.

Далее происходит добавление порядкового номера строки (`__rn`) для каждой группы (`qid`), упорядоченной по дате, приоритету и идентификатору.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `attr_myfirstfunnel_add_row_number`

Содержимое файла:
```sql
-- depends_on: {{ ref('attr_myfirstfunnel_create_events') }}

{{ datacraft.attr() }}
```
