---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize
doc_status: ready
language: eng
---
# macro `normalize_name`

## Summary

This macro takes a `name` as an argument and returns a version of it that can be used as a column name. 

## Arguments

01. `name` (required argument - the name to be normalized, in string format)

## Functionality

```sql
{{ etlcraft.normalize_name(name) }}
```

This macro takes a `name` as an argument and returns a version of it that can be used as a column name. The normalization process includes the following steps:

1. Replace spaces with underscores.
2. Transliterate any Cyrillic letters to their Latin equivalents.
3. Remove non-alphanumeric symbols.

 Example:

```sql
-- Normalize a column name
{{ etlcraft.normalize_name('My Column Name') }}
```
Output:
```sql
My_Column_Name
```
