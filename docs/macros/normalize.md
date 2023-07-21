# dbt `normalize` Macro Documentation

The `normalize` macro is designed to normalize tables that are downloaded by Airbyte. This macro accepts three optional arguments:

1. `included_fields` (default: empty list)
2. `excluded_fields` (default: empty list)
3. `defaults_dict` (default: result of `etlcraft_defaults()` macro)
4. `source_table` (default: none)
5. `override_target_model_name` (default: none)

## Macro behavior

The behavior of the `normalize` macro depends on the name of the model. The model name must follow the pattern `normalize_{sourcetypename}_{templatename}_{streamname}` with an optional suffix `_auto`. The macro extracts `sourcetypename`, `templatename`, and `streamname`, and creates a union of the tables `_airbyte_{sourcetypename}_%_{templatename}_{streamname}`. 

To facilitate testing, an argument called `override_target_model_name` is provided. When this argument is used, the macro behaves as if it were in a model with a name equal to the value of `override_target_model_name`.

If `source_table` argument is not provided, the macro utilizes `dbt_utils.union(dbt_utils.get_relations_by_pattern(schema_pattern, table_pattern)))` to get all the relevant tables if. `schema_pattern` is the name of the current schema and `table_pattern` is as above.

These tables contain columns `_airbyte_ab_id`, `_airbyte_data` and `_airbyte_emited_at`. `_airbyte_data` is a JSON field that contains the data to be normalized. The macro looks at the first line of the first column and detects the list of keys in the JSON field.

Then the macro iterates over that list and for each key, adds a line to a column list of the SELECT query to be returned. The generated line uses the macro `json_extract_string(_airbyte_emitted_at, {key_name})` to get the corresponding key from the JSON field. It also contains an AS expression, that names the column as the `{key_name}`, but after transformation with the macro `normalize_name(key_name)` that removes spaces, transliterates Cyrillic symbols, etc.

When forming `column_list`, the macro adds fields from the `included_fields` argument, then `defaults_dict['sourcetypes'][source_type]['included_fields']`, then `defaults_dict['sourcetypes'][source_type]['streams'][stream_name]['included_fields']`. It then excludes fields from the `excluded_field` argument, then `defaults_dict['sourcetypes'][source_type]['excluded_fields']`, then `defaults_dict['sourcetypes'][source_type]['streams'][stream_name]['included_fields']`.

Note that the corresponding key may not exist in the dictionary, in which case you should consider them as empty. For example, if there is no 'source_type' key in `default_dict['sourcetypes']`, you just go to the next line. Also, the `column_list` must contain only unique names of columns, no duplication is allowed even if the same column is in the initial `column_list` and in `included_fields`.