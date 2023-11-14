# array

## Summary

The `array` macro is a dbt utility macro used to create an SQL array from an array argument. This macro supports different SQL dialects and uses the corresponding syntax for array creation. The default implementation of this macro uses PostgreSQL-like syntax, which is widely compatible with many SQL dialects. There is also a ClickHouse-specific implementation for projects that use a ClickHouse adapter.

## Signature

```sql
{% macro etlcraft.array(arr) %}
```
## Arguments
`arr` : An array object that you want to transform into an SQL array. The array object should be in Python list format, e.g., `['item1', 'item2', 'item3']`.

## Usage
You can use this macro in any SQL statement where you need to construct an array. Simply call the macro and pass the array as the argument. For example:

```sql
{{ array(['item1', 'item2', 'item3']) }}
```

This macro is also dispatched, meaning that it uses the dbt adapter pattern to support different SQL dialects.

**Перевод**
 
# Макрос array

## Описание

Макрос array - это утилитарный макрос dbt, используемый для создания SQL-массива из аргумента-массива. Этот макрос поддерживает различные диалекты SQL и использует соответствующий синтаксис для создания массива. Реализация по умолчанию этого макроса использует синтаксис, подобный PostgreSQL, который широко совместим с многими диалектами SQL. Также существует реализация, специфичная для ClickHouse, для проектов, использующих адаптер ClickHouse.

## Сигнатура

{% macro etlcraft.array(arr) %}

## Аргументы

arr : Объект-массив, который вы хотите преобразовать в SQL-массив. Объект-массив должен быть в формате списка Python, например, ['элемент1', 'элемент2', 'элемент3'].

## Использование

Вы можете использовать этот макрос в любом SQL-выражении, где вам нужно создать массив. Просто вызовите макрос и передайте массив в качестве аргумента. Например:
{{ array(['элемент1', 'элемент2', 'элемент3']) }}
Этот макрос также диспетчируется, что означает, что он использует шаблон адаптера dbt для поддержки различных диалектов SQL. 