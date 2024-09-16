---
step: other
---
This macro likequerycycle allows you to create SQL queries using the LIKE operator to search for substrings in the specified value.

## Syntax

```sql
{% macro likequerycycle(list, value) %}
    {% for element in list %}
        {% if not loop.last %}
            {{ value }} like '%{{ element }}%' OR
        {% elif loop.first %}
             {{ value }} like '%{{ element }}%'
        {% else %}
            {{ value }} like '%{{ element }}%'
        {% endif %}
    {% endfor %}
{% endmacro %}
```

## Parameters
- `list`: List of values to search for
- `value`: Value in which the substring search will be performed
## Example usage

```sql
{{ likequerycycle('apple', 'banana', 'cherry', 'fruit') }}
```

Result:
fruit like '%apple%' OR fruit like '%banana%' OR fruit like '%cherry%'

Please note that this documentation is preliminary and may be supplemented or changed in the future.

**Перевод**
 
Данный макрос `like_query_cycle` позволяет создавать SQL-запросы с использованием оператора `LIKE` для поиска подстрок в указанном значении.

## Синтаксис

```sql
{% macro like_query_cycle(list, value) %}
    {% for element in list %}
        {% if not loop.last %}
            {{ value }} like '%_{{ element }}_%' OR
        {% elif loop.first %}
             {{ value }} like '%_{{ element }}_%'
        {% else %}
            {{ value }} like '%_{{ element }}_%'
        {% endif %}
    {% endfor %}
{% endmacro %}

```

## Параметры

- `list`: Список значений, по которым будет производиться поиск
- `value`: Значение, в котором будет выполняться поиск подстрок

## Пример использования

```sql
{{ like_query_cycle(['apple', 'banana', 'cherry'], 'fruit') }}

```

Результат:

```
fruit like '%_apple_%' OR fruit like '%_banana_%' OR fruit like '%_cherry_%'

```

Пожалуйста, обратите внимание, что данная документация является предварительной и может быть дополнена или изменена в будущем.