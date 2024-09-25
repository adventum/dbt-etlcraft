---
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



## Аргументы

Этот макрос принимает следующие аргументы:
```sql
SOMETHING
```
## Функциональность



## Пример


