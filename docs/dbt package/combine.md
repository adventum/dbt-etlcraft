---
category: main
step: 2_staging
sub_step: 2_combine
doc_status:
---
# macro `combine`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt package"
WHERE file.name != "README" AND contains(in_main_macro, "LOOK HERE")
SORT doc_status
```


## Summary

## Usage

## Arguments

This macro accepts the following arguments:

## Functionality

## Example
## Notes

**Перевод**

## Описание

## Применение

## Аргументы

Этот макрос принимает следующие аргументы:

## Функциональность

## Пример

Файл в формате sql в папке models. Название файла `[NAME]`

Содержимое файла:
```sql
SOMETHING INSIDE
```

## Примечания

Это N-й из основных макросов.