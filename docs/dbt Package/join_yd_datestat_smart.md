---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: empty_template
---
# macro `join_yd_datestat_smart`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_yd_datestat_smart")
SORT doc_status
```
## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `yd` (они относятся к пайплайну `datestat`) - отдельная версия именно для smart.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
SOMETHING
```
## Функциональность

## Пример

Файл в формате sql в папке models. Название файла `[NAME]`

Содержимое файла:
```sql
SOMETHING INSIDE
```
