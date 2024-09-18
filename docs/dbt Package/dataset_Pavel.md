---
step: 7_dataset
---
## dataset macro documentation

The dataset macro is used to create an SQL query that retrieves data from the master table with the ability to filter by table prefixes.

### Parameters

- `table_prefixes` (optional): A string or list of table prefixes to filter the data by.

### Usage example
```sql
{% macro dataset( table_prefixes = none) %}
{{
    config(
        materialized='table',
        order_by='toDate(__datetime)'
        )
     }}
    SELECT
        *
    FROM {{ ref('master') }}
    {% if table_prefixes is not none %}
    WHERE
        ({{ etlcraft.like_query_cycle(table_prefixes,'__table_name') }})
    {% endif %}
{% endmacro %}
```

This macro creates an SQL query that retrieves all columns from the master table. If table prefixes are specified in the table_prefixes parameter, the data will be filtered by these prefixes.

**Перевод**
 
## Документация по макросу `dataset`

Макрос `dataset` используется для создания SQL запроса, который извлекает данные из таблицы `master` с возможностью фильтрации по префиксам таблиц.

### Параметры

- `table_prefixes` (необязательный): Строка или список префиксов таблиц, по которым необходимо фильтровать данные.

### Пример использования

```sql
{% macro dataset( table_prefixes = none) %}

{{
    config(
        materialized='table',
        order_by='toDate(__datetime)'
        )
     }}

    SELECT
        *
    FROM {{ ref('master') }}
    {% if table_prefixes is not none %}
    WHERE
        ({{ etlcraft.like_query_cycle(table_prefixes,'__table_name') }})
    {% endif %}

{% endmacro %}

```

Данный макрос создает SQL запрос, который извлекает все столбцы из таблицы `master`. Если указаны префиксы таблиц в параметре `table_prefixes`, то данные будут фильтроваться по этим префиксам.