---
category: main
step: 2_staging
sub_step: 1_join
doc_status:
---
# macro `join`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt package"
WHERE file.name != "README" AND contains(in_main_macro, "join")
SORT doc_status
```

## Summary

## Usage

## Arguments

## Functionality

## Example
## Notes

**Перевод**

## Описание

Макрос `join` предназначен для соединения разных потоков  данных (стримов) одного источника.

## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`join_{название_источника}_{название_пайплайна}`.

Например, `join_appmetrica_events`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.join() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('incremental_appmetrica_events_default_deeplinks') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_events') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_installations') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_screen_view') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_sessions_starts') }}

{{ etlcraft.join() }}
```
Технически макрос `join` - регулировщик. Поскольку данные в разных источниках организованы по-разному, внутри для каждого источника будет действовать своя разновидность макроса `join`, внутри которой и происходит основная работа с данными.
Например, макрос `join` перенаправляет данные из источника `appmetrica` в макрос `join_appmetrica_events`, а данные из источника `ym` в макрос `join_ym_events`.

## Аргументы

Этот макрос принимает следующие аргументы:

1. params (по умолчанию: none)
2.  disable_incremental (по умолчанию: none)
3. override_target_model_name (по умолчанию: none)
4. date_from (по умолчанию: none)
5. date_to (по умолчанию: none)
6. limit0 (по умолчанию: none)

## Функциональность

Сначала макрос считает имя модели - либо из передаваемого аргумента (
`override_target_model_name`), либо из имени файла (`this.name`). При использовании аргумента `override_target_model_name` макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Название модели, полученное тем или иным способом, разбивается на части по знаку нижнего подчёркивания. Например, название `join_appmetrica_events` разобьётся на 3 части, из этих частей макрос возьмёт в работу:
- источник - `sourcetype_name` → appmetrica
- пайплайн - `pipeline_name` → events

Для некоторых моделей, например, для `join_appmetrica_registry_appprofilematching`,
макрос возьмёт ещё:
- линк - `link_name` →appprofilematching

Если пайплайн соответствует направлениям `registry` или `periodstat`, то автоматически задаётся аргумент `disable_incremental`, равный `True`. Это значит, что в таких данных нет инкрементального поля с датой.

Далее макрос генерирует имя того макроса join, куда стоит перенаправить эти данные.
  
Если пайплайн не является `registry`, то паттерн будет таким:

`'join_'~ sourcetype_name ~'_'~ pipeline_name`

Для данных пайплайна `registry` паттерн будет чуть длиннее:

`'join_'~ sourcetype_name ~'_'~ pipeline_name ~ '_' ~ link_name`

Также дополнительно вводится разграничение для двух видов yandex direct - со смарт-кампаниями и без них (они будут обрабатываться отдельно).

Когда имя макроса, куда стоит перенаправить данные, определено, макрос join вызывает его.

## Пример

## Примечания