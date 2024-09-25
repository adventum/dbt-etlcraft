---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize
doc_status: ready
---
# macro `json_extract_string`

## Описание

Этот макрос используется для извлечения строкового значения из объекта JSON в SQL-запросе.

## Аргументы

- json_field: Этот аргумент должен быть именем столбца, который содержит JSON-данные, из которых вы хотите извлечь строку.
- key: Этот аргумент должен быть ключом в объекте JSON, из которого вы хотите извлечь строку.

## Функциональность

Предположим, у вас есть таблица orders с JSON-столбцом metadata, и вы хотите извлечь из него customer_id. Вот как вы можете использовать макрос json_extract_string в модели DBT: 

```sql
SELECT
  order_id,
  {{ etlcraft.json_extract_string('metadata', 'customer_id') }} as customer_id,
  order_date
FROM
  orders
```
Возвращаемое значение:

Этот макрос возвращает фрагмент SQL, который можно использовать в операторе SELECT для извлечения строки из JSON-поля. 