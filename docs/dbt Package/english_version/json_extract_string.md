---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize
doc_status: ready
language: eng
---
# macro `json_extract_string`

## Summary

This macro is used to extract a string value from a JSON object in a SQL query. 

## Arguments

- `json_field`: This argument should be the name of the column that contains the JSON data from which you want to extract the string.
- `key`: This argument should be the key in the JSON object from which you want to extract the string.

## Functionality

Suppose you have a table `orders` with a JSON column `metadata` and you want to extract the `customer_id` from it. Here's how you could use the `json_extract_string` macro in a DBT model:

```sql
SELECT
  order_id,
  {{ etlcraft.json_extract_string('metadata', 'customer_id') }} as customer_id,
  order_date
FROM
  orders
```

Returns:

This macro returns a SQL snippet that can be used in a SELECT statement to extract a string from a JSON field.


