# json_list_keys

This macro is used to list all keys in a JSON object in a SQL query.

## Arguments

- `json_field`: This argument should be the name of the column that contains the JSON data for which you want to list the keys.

## Usage

Suppose you have a table `orders` with a JSON column `metadata` and you want to extract all keys from it. Here's how you could use the `json_list_keys` macro in a DBT model:

```sql
SELECT
  order_id,
  {{ etlcraft.json_list_keys('metadata') }} as json_keys,
  order_date
FROM
  orders
```

## Returns
This macro returns a SQL snippet that can be used in a SELECT statement to list all keys from a JSON field.


**Перевод**

# json_list_keys

Этот макрос используется для перечисления всех ключей в объекте JSON в SQL-запросе.

## Аргументы

- json_field: Этот аргумент должен быть именем столбца, который содержит JSON-данные, для которых вы хотите перечислить ключи.

## Использование

Предположим, у вас есть таблица orders с JSON-столбцом metadata, и вы хотите извлечь из него все ключи. Вот как вы можете использовать макрос json_list_keys в модели DBT: 

```sql
SELECT
  order_id,
  {{ etlcraft.json_list_keys('metadata') }} as json_keys,
  order_date
FROM
  orders
```
## Возвращаемое значение

Этот макрос возвращает фрагмент SQL, который можно использовать в операторе SELECT для перечисления всех ключей из JSON-поля. 