---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: ready
---
# macro `join_appmetrica_registry_appprofilematching`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_appmetrica_registry_appprofilematching")
SORT doc_status
```


## Описание

Подвид макроса `join`. Этот подвид макроса предназначен для работы с данными источника `appmetrica`, которые относятся к пайплайну `registry` (стрим `profiles`).

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params,
    limit0=none
    ```
## Функциональность

Макрос обрабатывает данные стрима `profiles` из источника `appmetrica`. Данные о профилях относятся к общей справочной информации - то есть к пайплайну `registry`.

Для вышеуказанного стрима макрос ищет `relations` при помощи вспомогательного макроса [[get_relations_by_re]], затем создаёт таблицу-источник при помощи вспомогательного макроса `dbt_utils.union_relations`. (Этот макрос из пакета dbt_utils, он не относится к etlcraft).

Далее полученные данные макрос обрабатывает (происходит переименование полей, для некоторых столбцов вводится LowCardinality).

Для этой таблицы задаётся её линк (это будет использоваться на будущих шагах):
- `toLowCardinality('AppProfileMatching') AS __link`

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `join_appmetrica_registry_appprofilematching`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_appmetrica_registry_default_profiles') }}

{{ etlcraft.join(disable_incremental=True) }}
```

