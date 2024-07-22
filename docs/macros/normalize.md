# dbt `normalize` Macro Documentation

The `normalize` macro is designed to normalize tables that are downloaded by Airbyte. This macro accepts three optional arguments:

1. `included_fields` (default: empty list)
2. `excluded_fields` (default: empty list)
3. `defaults_dict` (default: result of `etlcraft_defaults()` macro)
4. `schema_pattern` (default: `this.schema`)
5. `source_table` (default: none)
6. `override_target_model_name` (default: none)

## Macro behavior

The behavior of the `normalize` macro depends on the name of the model. The model name must follow the pattern `normalize_{sourcetypename}_{templatename}_{streamname}`. The macro extracts `sourcetypename`, `templatename`, and `streamname`, and creates a union of the tables `_airbyte_{sourcetypename}_{templatename}_%_{streamname}`. 

To facilitate testing, an argument called `override_target_model_name` is provided. When this argument is used, the macro behaves as if it were in a model with a name equal to the value of `override_target_model_name`.

If `source_table` argument is not provided, the macro utilizes `dbt_utils.union(dbt_utils.get_relations_by_re(schema_pattern, table_pattern)))` to get all the relevant tables where `table_pattern` is as above.

These tables contain columns `_airbyte_ab_id`, `_airbyte_data` and `_airbyte_emitted_at`. `_airbyte_data` is a JSON field that contains the data to be normalized. The macro looks at the first line of the first column and detects the list of keys in the JSON field.

Then the macro iterates over that list and for each key, adds a line to a column list of the SELECT query to be returned. The generated line uses the macro `json_extract_string(_airbyte_emitted_at, {key_name})` to get the corresponding key from the JSON field. It also contains an AS expression, that names the column as the `{key_name}`, but after transformation with the macro `normalize_name(key_name)` that removes spaces, transliterates Cyrillic symbols, etc.

When forming `column_list`, the macro adds fields from the `included_fields` argument, then `defaults_dict['sourcetypes'][source_type]['included_fields']`, then `defaults_dict['sourcetypes'][source_type]['streams'][stream_name]['included_fields']`. It then excludes fields from the `excluded_field` argument, then `defaults_dict['sourcetypes'][source_type]['excluded_fields']`, then `defaults_dict['sourcetypes'][source_type]['streams'][stream_name]['included_fields']`.


**Перевод**
 
# Документация по макросу нормализации dbt

Макрос нормализации предназначен для нормализации таблиц, загруженных Airbyte. Этот макрос принимает три необязательных аргумента:

1. `included_fields` (по умолчанию: пустой список)
2. `excluded_fields` (по умолчанию: пустой список)
3. `defaults_dict` (по умолчанию: результат макроса etlcraft_defaults())
4. `schema_pattern` (по умолчанию: this.schema)
5. `source_table` (по умолчанию: отсутствует)
6. `override_target_model_name` (по умолчанию: отсутствует) 

## Поведение макроса

Поведение макроса нормализации зависит от имени модели. Имя модели должно соответствовать шаблону `normalize_{название_типа_источника}_{название_шаблона}_{название_потока}`. Макрос извлекает названия типа источника, шаблона и потока, и создает объединение таблиц `_airbyte_{название_типа_источника}_{название_шаблона}_%_{название_потока}`.

Для облегчения тестирования предоставляется аргумент `override_target_model_name`. При использовании этого аргумента макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Если аргумент source_table не предоставлен, макрос использует `dbt_utils.union(dbt_utils.get_relations_by_re(schema_pattern, table_pattern))` для получения всех соответствующих таблиц, где `table_pattern` соответствует вышеупомянутому шаблону.

Эти таблицы содержат столбцы `_airbyte_ab_id`,` _airbyte_data` и `_airbyte_emitted_at`. `_airbyte_data` - это JSON-поле, которое содержит данные, подлежащие нормализации. Макрос смотрит на первую строку первого столбца и определяет список ключей в JSON-поле.

Затем макрос перебирает этот список и для каждого ключа добавляет строку в список столбцов запроса `SELECT`, который должен быть возвращен. Сгенерированная строка использует макрос `json_extract_string(_airbyte_emitted_at, {key_name})` для извлечения соответствующего ключа из JSON-поля. Она также содержит выражение AS, которое называет столбец как `{key_name}`, но после преобразования с помощью макроса `normalize_name(key_name)`, который удаляет пробелы, транслитерирует кириллические символы, и т. д.

При формировании списка столбцов макрос добавляет поля из аргумента `included_fields`, затем `defaults_dict['sourcetypes'][source_type]['included_fields']`, затем `defaults_dict['sourcetypes'][source_type]['streams'][stream_name]['included_fields']`. Затем он исключает поля из аргумента `excluded_field`, затем` defaults_dict['sourcetypes'][source_type]['excluded_fields']`, затем `defaults_dict['sourcetypes'][source_type]['streams'][stream_name]['included_fields']`. 