---
category: sub_main
step: 6_attribution
sub_step: 5_calculate_period_number
in_main_macro: attr
doc_status: ready
---
# macro `attr_calculate_period_number`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "attr_calculate_period_number")
SORT doc_status
```
## Описание

Это пятый шаг макроса `attr`.  Этот макрос вычисляет номер периода для каждого события в атрибуции. Это важно для последующего анализа данных и определения их временного распределения.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params = none,
  funnel_name=none,
  limit0=none
```
## Функциональность

  Сначала в макросе происходит настройка материализации данных: устанавливается порядок сортировки данных по идентификатору группы, дате, источнику записи и идентификатору.

Далее происходит вычисление номера периода для каждой группы (`qid`).

Суммирование значения `__is_new_period` для каждой строки в группе дает номер текущего периода.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `attr_myfirstfunnel_calculate_period_number`

Содержимое файла:
```sql
-- depends_on: {{ ref('attr_myfirstfunnel_find_new_period') }}

{{ datacraft.attr() }}
```
