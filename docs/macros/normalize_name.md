# normalize_name

This macro takes a `name` as an argument and returns a version of it that can be used as a column name. The normalization process includes the following steps:

1. Replace spaces with underscores.
2. Transliterate any Cyrillic letters to their Latin equivalents.
3. Remove non-alphanumeric symbols.


## Usage

```sql
{{ normalize_name(name) }}
```
## Arguments
+ `name` (string): The name to be normalized.

## Example
```sql
-- Normalize a column name
{{ normalize_name('My Column Name') }}
```
## Output
```sql
My_Column_Name
```

