## Incremental Table Macro

This macro facilitates the creation and management of incremental tables in dbt, based on a specific naming pattern.

### Naming Convention

The model using this macro must be named according to the following pattern:
```
incremental_{sourcetypename}_{templatename}_{streamname}
```

### Functionality

The macro locates a corresponding table prefixed with `normalize_{sourcetypename}_{templatename}_{streamname}`, and executes a SELECT * operation on it. If an incremental datetime field (IDF) is determined by using the `find_incremental_datetime_field` macro (or if provided in argument), it makes an incremental model and casts the IDF to datetime using the `cast_datetime_field` macro. If the IDF is not found, the macro either materializes the corresponding normalized relation or serves as a proxy view for it.

### How the Incremental Model Works

- **Indexing:** The table is indexed by IDF (primary) and table_name (secondary).
- **Pre-hook Deletion:** In a pre-hook operation, the macro deletes the rows from the current table where the dates of the IDF fields correspond to the dates in the normalized relation (taking the table name into account).
- **Data Insertion:** All data from the normalized relation is inserted into the current table.

### Example

Imagine an incremental table A with data from table B (for dates 01.07-03.07) and table C (for dates 02.07-04.07). If the normalized relation has data from B and C for date 03.07-05.07, the macro will remove the old rows from A corresponding to B for 03.07 and C for 03.07 and 04.07. Then, the entire content of the normalized relation will be inserted into A.

### Usage
```sql
{{ incremental_table(incremental_datetime_field=YOUR_DATETIME_FIELD) }}
```
Provide the `incremental_datetime_field` argument if a specific IDF is required. Otherwise, the macro will attempt to identify it automatically.
