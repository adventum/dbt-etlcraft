# get_column_count_in_subquery

The `get_column_count_in_subquery` macro takes a subquery (as a string) as an argument and returns the count of columns in that subquery.

## Usage

```sql
{% set subquery = "SELECT col1, col2 FROM my_table" %}
SELECT get_column_count_in_subquery(subquery) AS cnt
```

In the above example, if my_table has columns `col1` and `col2`, then `column_count` will be set to `2`.

This macro can be useful when you need to dynamically check the number of columns in a subquery in your dbt transformations.

## Notes
This macro is specific to ClickHouse SQL dialect, and will not work in other dialects like PostgreSQL or MySQL. Also, it might not correctly handle subqueries with complex column manipulations. Always test to ensure accurate results for your specific subquery.