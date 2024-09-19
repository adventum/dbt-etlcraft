---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: ready
---
# macro `join_mt_datestat`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_mt_datestat")
SORT doc_status
```
## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `my target`( эти данные относятся к пайплайну `datestat`).

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

Макрос объединяет данные разных стримов, относящихся к источнику `mt`.

Стримы:
- banners_statistics
- banners
- campaigns

Для каждого стрима макрос ищет `relations` при помощи вспомогательного макроса [[get_relations_by_re]], затем создаёт таблицу-источник при помощи вспомогательного макроса `dbt_utils.union_relations`. (Этот макрос из пакета dbt_utils, он не относится к etlcraft).

При помощи дополнительного макроса [[get_min_max_date]] в макросе задаются переменные 
`date_from` и `date_to`, которые участвуют в отборе данных.

Далее полученные данные из этих стримов соединяются (джойнятся) по id баннеров и кампаний. 

Для этой таблицы задаётся её линк (это будет использоваться на будущих шагах):
- `toLowCardinality('AdCostStat') AS __link`

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

## Пример

Файл в формате sql в папке models. Название файла `join_mt_datestat`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_mt_datestat_default_banners_statistics') }}

-- depends_on: {{ ref('incremental_mt_registry_default_banners') }}

-- depends_on: {{ ref('incremental_mt_registry_default_campaigns') }}

{{ etlcraft.join() }}
```
