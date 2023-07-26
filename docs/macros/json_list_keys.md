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