---
step: other
doc_status: Pavel
---
## Documentation for the check_table_exists macro

```python
{% macro check_table_exists(source_table = 'master',database = 'marts') -%}
  {{ adapter.dispatch('check_table_exists', 'etlcraft')(source_table,database) }}
{%- endmacro %}
```

```python
{% macro clickhouse__check_table_exists(source_table,database) -%}
    {% set sql_statement %}
        SELECT 1 FROM system.tables WHERE database = '{{database}}' AND name = '{{source_table}}'
    {% endset %}
    {% if execute %}
        {% set results = run_query(sql_statement) %}
        {% if results|length > 0 %}
            {{ return(1) }}
        {% else %}
            {{ return(0) }}
        {% endif %}
    {% else %}
        {{ return(0) }}
    {% endif %}
{%- endmacro %}
```

This check_table_exists macro allows you to check the existence of a table in a database. By default, it takes two arguments: source_table (table name) and database (database name).

### Example usage

```python
{% set table_exists = check_table_exists('my_table', 'my_database') %}
{% if table_exists %}
    The table exists.
{% else %}
    The table does not exist.
{% endif %}
```

### Macro parameters

- source_table (optional): The name of the table to check. Default value is 'master'.
- database (optional): The name of the database to check the table existence. Default value is 'marts'.
> Note: Please make sure you have the necessary database access rights to perform this check.


**Перевод**
 
## Документация для макроса `check_table_exists`

```python
{% macro check_table_exists(source_table = 'master',database = 'marts') -%}
  {{ adapter.dispatch('check_table_exists', 'etlcraft')(source_table,database) }}
{%- endmacro %}

```

```python
{% macro clickhouse__check_table_exists(source_table,database) -%}
    {% set sql_statement %}
        SELECT 1 FROM system.tables WHERE database = '{{database}}' AND name = '{{source_table}}'
    {% endset %}
    {% if execute %}
        {% set results = run_query(sql_statement) %}
        {% if results|length > 0 %}
            {{ return(1) }}
        {% else %}
            {{ return(0) }}
        {% endif %}
    {% else %}
        {{ return(0) }}
    {% endif %}
{%- endmacro %}

```

Этот макрос `check_table_exists` предоставляет возможность проверить существование таблицы в базе данных. По умолчанию, он принимает два аргумента: `source_table` (имя таблицы) и `database` (имя базы данных).

### Пример использования

```python
{% set table_exists = check_table_exists('my_table', 'my_database') %}
{% if table_exists %}
    Таблица существует.
{% else %}
    Таблица не существует.
{% endif %}

```

### Параметры макроса

- `source_table` (необязательный): Имя таблицы, которую нужно проверить. По умолчанию установлено значение `'master'`.
- `database` (необязательный): Имя базы данных, в которой нужно проверить существование таблицы. По умолчанию установлено значение `'marts'`.

> Примечание: Пожалуйста, убедитесь, что у вас есть права доступа к базе данных для выполнения данной проверки.
>