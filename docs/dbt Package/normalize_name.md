---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize
doc_status: ready
---
# macro `normalize_name`

## Summary

This macro takes a `name` as an argument and returns a version of it that can be used as a column name. 

## Usage

```sql
{{ etlcraft.normalize_name(name) }}
```

## Arguments

01. `name` (required argument - the name to be normalized, in string format)

## Functionality

This macro takes a `name` as an argument and returns a version of it that can be used as a column name. The normalization process includes the following steps:

1. Replace spaces with underscores.
2. Transliterate any Cyrillic letters to their Latin equivalents.
3. Remove non-alphanumeric symbols.

## Example

```sql
-- Normalize a column name
{{ etlcraft.normalize_name('My Column Name') }}
```
Output:
```sql
My_Column_Name
```
## Notes

This is an auxiliary macro. It is used in the `normalize` macro.

**Перевод**

## Описание

Этот макрос принимает имя в качестве аргумента и возвращает его версию, которая может быть использована в качестве имени столбца.
## Применение

```sql
{{ etlcraft.normalize_name(name) }}
```

## Аргументы

01. name (обязательный аргумент - имя, которое нужно нормализовать, в формате string)

## Функциональность

Этот макрос принимает имя в качестве аргумента и возвращает его версию, которая может быть использована в качестве имени столбца. Процесс нормализации включает следующие шаги:
1. Замена пробелов подчеркиваниями.
2. Транслитерация любых кириллических букв на их латинские эквиваленты.
3. Удаление не буквенно-цифровых символов.

## Пример

```sql
-- Нормализация имени столбца
{{ etlcraft.normalize_name('Название Моего Столбца') }}
```
Вывод:
```sql
Nazvanie_Moego_Stolbca 
```
## Примечания

Это вспомогательный макрос. Он используется в макросе `normalize`.






