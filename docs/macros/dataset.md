## окументация по макросу `dataset`

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