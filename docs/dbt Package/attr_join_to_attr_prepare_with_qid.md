---
category: sub_main
step: 6_attribution
sub_step: 7_join_to_attr_prepare_with_qid
in_main_macro: attr
doc_status: ready
---
# macro `attr_join_to_attr_prepare_with_qid`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "attr_join_to_attr_prepare_with_qid")
SORT doc_status
```
## Описание

Это седьмой шаг макроса `attr`. Этот макрос присоединяет данные из различных этапов атрибуции для последующего анализа.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params = none,
  funnel_name=none,
  limit0=none,
  metadata=project_metadata()
```
## Функциональность

Сначала в макросе происходит извлечение метаданных для определения типов моделей и их приоритетов.

Далее - создание словаря для хранения информации о моделях. Каждая модель представлена как ключ, а её тип как значения.

Далее происходит настройка материализации данных: устанавливается порядок сортировки данных по идентификатору группы, номеру периода, дате, приоритету и идентификатору.

После этого происходит объединение результатов двух запросов: `attr_prepare_with_qid` и `attr_create_missed_steps`.

Далее - вычисление ранга для каждой модели в зависимости от ее приоритета.

После этого идёт определение `adSourceDirty` для каждого события в зависимости от его приоритета и флага пропущенного шага.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `attr_myfirstfunnel_join_to_attr_prepare_with_qid`

Содержимое файла:
```sql
-- depends_on: {{ ref('attr_myfirstfunnel_prepare_with_qid') }}

-- depends_on: {{ ref('attr_myfirstfunnel_create_missed_steps') }}

{{ datacraft.attr() }}
```
