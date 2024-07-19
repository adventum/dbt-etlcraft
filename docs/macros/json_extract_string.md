# json_extract_string

This macro is used to extract a string value from a JSON object in a SQL query. 

## Arguments

- `json_field`: This argument should be the name of the column that contains the JSON data from which you want to extract the string.
- `key`: This argument should be the key in the JSON object from which you want to extract the string.

## Usage

Suppose you have a table `orders` with a JSON column `metadata` and you want to extract the `customer_id` from it. Here's how you could use the `json_extract_string` macro in a DBT model:

```sql
SELECT
  order_id,
  {{ etlcraft.json_extract_string('metadata', 'customer_id') }} as customer_id,
  order_date
FROM
  orders
```

## Returns
This macro returns a SQL snippet that can be used in a SELECT statement to extract a string from a JSON field.


**Перевод**

# json_extract_string

Этот макрос используется для извлечения строкового значения из объекта JSON в SQL-запросе.

## Аргументы

- json_field: Этот аргумент должен быть именем столбца, который содержит JSON-данные, из которых вы хотите извлечь строку.
- key: Этот аргумент должен быть ключом в объекте JSON, из которого вы хотите извлечь строку.

## Использование

Предположим, у вас есть таблица orders с JSON-столбцом metadata, и вы хотите извлечь из него customer_id. Вот как вы можете использовать макрос json_extract_string в модели DBT: 

```sql
SELECT
  order_id,
  {{ etlcraft.json_extract_string('metadata', 'customer_id') }} as customer_id,
  order_date
FROM
  orders
```
## Возвращаемое значение

Этот макрос возвращает фрагмент SQL, который можно использовать в операторе SELECT для извлечения строки из JSON-поля. 