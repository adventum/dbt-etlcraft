---
category: main
step: 1_silos
sub_step: 2_incremental
doc_status: ready
language: rus
---
# macro `incremental`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "incremental")
SORT doc_status
```

## Описание

Макрос `incremental` предназначен для создания инкрементальных таблиц - то есть таких таблиц, где исторически накапливаются данные. Основой для данного шага являются данные, полученные из моделей шага `normalize`.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`incremental_{название_источника}_{название_пайплайна}_{название_шаблона}_{название_потока}`.

Например, `incremental_appmetrica_events_default_deeplinks`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.incremental() }}
```
С этого шага и далее над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('normalize_appmetrica_events_default_deeplinks') }}

{{ etlcraft.incremental() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:
 
1. `defaults_dict` (по умолчанию: результат макроса fieldconfig())
2. `disable_incremental` (по умолчанию False)
3. `limit0` (по умолчанию: none)

## Функциональность

Сначала макрос читает имя модели через имеющееся имя файла (`this.name`).

Если имя модели не соответствует шаблону - макрос выдаст ошибку:

`"Model name does not match the expected naming convention: 'incremental_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}'."`

Далее макрос разбивает имя модели на части, и получает таким образом источник, пайплайн, шаблон, поток данных. Из этих данных макрос собирает паттерн, по которому далее будет искать соответствующую модель из шага `normalize`. Этот паттерн пригодится в разделе FROM в SQL-запросе.

Вот сам паттерн:

`'normalize_' ~ sourcetype_name ~ '_' ~ pipeline_name ~ '_' ~ template_name ~ '_' ~ stream_name`

В него подставляются значения из переменных, и в итоге макрос сможет найти для примера с `incremental_appmetrica_events_default_deeplinks` данные из `normalize_appmetrica_events_default_deeplinks` (потому что название модели данных шага `normalize` соответствует шаблону).

Если пайплайн соответствует направлениям `registry` или `periodstat`, то автоматически задаётся аргумент `disable_incremental_datetime_field`, равный `True`. Это значит, что в таких данных нет инкрементального поля с датой, и для этих данных макрос не будет пытаться искать такое поле.

Если пользователь при вызове макроса указал аргумент `disable_incremental` как `True`, то таблица не будет инкрементальной, будет обычной таблицей.

В остальных случаях (в том числе при вызове макроса по умолчанию) макрос будет искать инкрементальное поле с датой при помощи вспомогательного макроса `find_incremental_datetime_field`.

Если инкрементальное поле с датой так и не установлено, материализация будет как установлена как table:

```sql
    {{ config(

        materialized='table',

        order_by=('__table_name'),

        on_schema_change='fail'

    ) }}
```
  
Если же инкрементальное поле с датой установлено, материализация будет `incremental`:

```sql
    {{ config(

        materialized='incremental',

        order_by=('__date', '__table_name'),

        incremental_strategy='delete+insert',

        unique_key=['__date', '__table_name'],

        on_schema_change='fail'

    ) }}
```
  
Дополнительно макрос проверяет, есть ли в таблице предыдущего шага данные или та таблица пустая. Для этого используется вспомогательный макрос `check_table_empty`.

Далее происходит SELECT-запрос, который берёт все поля из соответствующей ему предыдущей таблицы, кроме поля с датой. Это поле замещается полем, обработанным макросом `cast_date_field`.

Если проверка таблицы шага normalize (при помощи макроса `check_table_empty`) показала, что та таблица непустая, то данные макрос возьмёт из неё. А если она пустая, то макрос шага incremental возьмёт данные из самого себя. Зачем это нужно? Предположим, вы обновляете данные по расписанию, а новых данных на первом шаге (`normalize`) не оказалось. В таком случае проект не должен падать с ошибкой, он сможет пойти дальше.

Если активирован аргумент `limit0` (который по умолчанию установлен как `none`), то в конце запроса будет прописан LIMIT 0.

## Пример

Файл в формате sql в папке models. Название файла `incremental_appmetrica_events_default_deeplinks`

Содержимое файла:
```sql
-- depends_on: {{ ref('normalize_appmetrica_events_default_deeplinks') }}

{{ etlcraft.incremental() }}
```
## Примечания

Это второй из основных макросов.
