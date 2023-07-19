# array

## Summary

The `array` macro is a dbt utility macro used to create an SQL array from an array argument. This macro supports different SQL dialects and uses the corresponding syntax for array creation. The default implementation of this macro uses PostgreSQL-like syntax, which is widely compatible with many SQL dialects. There is also a ClickHouse-specific implementation for projects that use a ClickHouse adapter.

## Signature

```sql
{% macro array(arr) %}
```
## Arguments
`arr` : An array object that you want to transform into an SQL array. The array object should be in Python list format, e.g., `['item1', 'item2', 'item3']`.

## Usage
You can use this macro in any SQL statement where you need to construct an array. Simply call the macro and pass the array as the argument. For example:

```sql
{{ array(['item1', 'item2', 'item3']) }}
```

This macro is also dispatched, meaning that it uses the dbt adapter pattern to support different SQL dialects.