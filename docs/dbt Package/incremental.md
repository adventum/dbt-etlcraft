---
category: main
step: 1_silos
sub_step: 2_incremental
doc_status:
---

 
## Макрос Инкрементной Таблицы

Этот макрос облегчает создание и управление инкрементными таблицами в dbt на основе определенного шаблона именования.

### Правила Именования

Модель, использующая этот макрос, должна иметь следующий шаблон имени:
`incremental_{название_типа_источника}_{название_шаблона}_{название_потока}`

### Функциональность

Макрос находит соответствующую таблицу с префиксом `normalize_{название_типа_источника}_{название_шаблона}_{название_потока`} и выполняет операцию `SELECT *` на ней. Если инкрементное поле даты и времени (IDF) определяется с использованием макроса `find_incremental_datetime_field` (или если оно предоставлено в качестве аргумента), он создает инкрементную модель и преобразует IDF в формат `datetime` с помощью макроса `cast_datetime_field`. Если IDF не найден, макрос либо материализует соответствующее нормализованное отношение, либо служит в качестве прокси-представления.

### Принцип работы Инкрементной Модели

- Индексация: Таблица индексируется по IDF (первичный) и названию таблицы (вторичный).
- Предварительное удаление: В предварительной операции макрос удаляет строки из текущей таблицы, где даты полей IDF соответствуют датам в нормализованном отношении (с учетом названия таблицы).
- Вставка данных: Все данные из нормализованного отношения вставляются в текущую таблицу.

### Пример

Представим инкрементную таблицу A с данными из таблицы B (для дат с 01.07 по 03.07) и таблицы C (для дат с 02.07 по 04.07). Если нормализованное отношение содержит данные из B и C для даты 03.07-05.07, макрос удалит старые строки из A, соответствующие B для 03.07 и C для 03.07 и 04.07. Затем вся содержимое нормализованного отношения будет вставлено в A.

### Использование

```sql
{{ incremental_table(incremental_datetime_field=ВАШЕ_ПОЛЕ_ДАТЫ_И_ВРЕМЕНИ) }}
```

Предоставьте аргумент `incremental_datetime_field`, если требуется конкретное IDF. В противном случае макрос попытается определить его автоматически. 



# macro `incremental`

## Summary

The `incremental` macro is designed to create incremental tables - that is, tables where data is historically accumulated. The basis for this step is the data obtained from the models of the `normalize` step.
## Usage

The name of the dbt model (= the name of the sql file in the models folder) must match the template: 
`incremental_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}`.

For example, `incremental_appmetrica_events_default_deeplinks`.

A macro is called inside this file like this:
```sql
{{ etlcraft.incremental() }}
```

From this step onwards, above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('normalize_appmetrica_events_default_deeplinks') }}

{{ etlcraft.incremental() }}
```

## Arguments

This macro accepts the following arguments:

1. `defaults_dict` (default: result of the fieldconfig() macro)
2. `disable_incremental` (default: False)
3. `limit0` (default: none)
## Functionality

## Example
## Notes

**Перевод**

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

## Пример

## Примечания