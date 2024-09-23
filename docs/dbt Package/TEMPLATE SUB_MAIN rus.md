---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: attr
doc_status: empty_template
---
# macro `MACRO_NAME`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "LOOK HERE")
SORT doc_status
```
## Описание

Это … шаг макроса `attr`. 

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
