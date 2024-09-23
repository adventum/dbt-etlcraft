---
category: sub_main
step: 6_attribution
sub_step: 2_create_events
in_main_macro: attr
doc_status: empty_template
---
# macro `attr_create_events`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "attr_create_events")
SORT doc_status
```
## Описание

Это второй шаг макроса `attr`. 

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
SOMETHING
```
## Функциональность



Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `[NAME]`

Содержимое файла:
```sql
SOMETHING INSIDE
```
