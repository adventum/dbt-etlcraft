---
step: other
---
# get_column_count_in_subquery

The `get_column_count_in_subquery` macro takes a subquery (as a string) as an argument and returns the count of columns in that subquery.

## Usage

```sql
{% set subquery = "SELECT col1, col2 FROM my_table" %}
SELECT etlcraft.get_column_count_in_subquery(subquery) AS cnt
```

In the above example, if my_table has columns `col1` and `col2`, then `column_count` will be set to `2`.

This macro can be useful when you need to dynamically check the number of columns in a subquery in your dbt transformations.

## Notes
This macro is specific to ClickHouse SQL dialect, and will not work in other dialects like PostgreSQL or MySQL. Also, it might not correctly handle subqueries with complex column manipulations. Always test to ensure accurate results for your specific subquery.

**Перевод**
 
# Макрос get_column_count_in_subquery

Макрос get_column_count_in_subquery принимает подзапрос (в виде строки) в качестве аргумента и возвращает количество столбцов в этом подзапросе.

## Использование

```sql
{% set subquery = "SELECT col1, col2 FROM my_table" %}
SELECT etlcraft.get_column_count_in_subquery(subquery) AS cnt
```
В приведенном выше примере, если у my_table есть столбцы col1 и col2, то column_count будет установлен в 2.
Этот макрос может быть полезен, когда вам нужно динамически проверить количество столбцов в подзапросе в ваших преобразованиях dbt.

## Примечания

Этот макрос специфичен для диалекта SQL ClickHouse и не будет работать в других диалектах, таких как PostgreSQL или MySQL. Кроме того, он может некорректно обрабатывать подзапросы с сложными манипуляциями столбцов. Всегда тестируйте, чтобы обеспечить точные результаты для вашего конкретного подзапроса. 