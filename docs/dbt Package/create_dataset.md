---
category: main
step: 7_dataset
sub_step: 
doc_status: empty_template
language: rus
---
# macro `create_dataset`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "create_dataset")
SORT doc_status
```

## Описание

Макрос `create_dataset` предназначен для создания финальной таблицы с учётом пожеланий клиента.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) для данного макроса не должно соответствовать какому-либо строгому шаблону. Модель можно назвать свободным образом по желанию клиента, но, соблюдая стиль etlcraft, можно рекомендовать название,

например, `dataset_event_table`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.create_dataset() }}
```
Особенность этого макроса в том, что он не опирается на название файла, в котором он вызывается. Но взамен он требует обязательной передачи аргументов `funnel` и `conditions`.

Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('full_datestat') }}

-- depends_on: {{ ref('attr_myfirstfunnel_final_table') }}

{{ etlcraft.create_dataset(

    funnel = 'myfirstfunnel',

    conditions =

    [{

    'pipeline':'datestat',

    'source': 'yd',

    'account': 'accountid',

    'preset': 'default'

    },

    {

    'pipeline': 'events',

    'source': 'appmetrica',

    'account': 'accountid',

    'preset': 'default'

    },

    {

    'pipeline':'events',

    'source': 'ym',

    'account': 'accountid',

    'preset': 'default'

    }

     ]

) }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

1. `funnel` (по умолчанию: none)
2. `conditions` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `limit0` (по умолчанию: none)
## Функциональность

## Пример

Файл в формате sql в папке models. Название файла в свободном формате.

Содержимое файла:
```sql
-- depends_on: {{ ref('full_datestat') }}

-- depends_on: {{ ref('attr_myfirstfunnel_final_table') }}

{{ etlcraft.create_dataset(

    funnel = 'myfirstfunnel',

    conditions =

    [{

    'pipeline':'datestat',

    'source': 'yd',

    'account': 'accountid',

    'preset': 'default'

    },

    {

    'pipeline': 'events',

    'source': 'appmetrica',

    'account': 'accountid',

    'preset': 'default'

    },

    {

    'pipeline':'events',

    'source': 'ym',

    'account': 'accountid',

    'preset': 'default'

    }

     ]

) }}
```

## Примечания

Это десятый из основных макросов.