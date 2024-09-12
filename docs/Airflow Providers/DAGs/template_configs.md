# `template_configs`

## Задача
DAG используется для генерации конфигов типа `templated_file` (см. [[Configs#Список конфигов]]). Он дает возможность задать и конфиг по умолчанию, который будет работать без какой-то настройки от пользователя, и  кастомный конфиг для конкретного проекта. DAG генерирует файлы конфигов в папке `templated_configs` внутри проекта dbt по следующим правилам:
- если в папке есть файл с названием `{название конфига}_manual.yaml` (или `.json`), то конфиг создается путем создания символической ссылки на него
- если файла нет, то копируется файл по умолчанию, то конфиг создается копированием соответствующего файла из папки `templated_configs`, но уже не проекта dbt, а репозитория самого **etlCraft**.

Можно также задавать несколько версий файлов по умолчанию. Для этого в папке `templated_configs` репозитория создается несколько файлов с разными суффиксами в конце, например, `metadata.yml`, `metadata_v2.yml`. Пользователь может указать, какую версию следует использовать с помощью указания пути (см. [[Configs#Метаконфиги]]).

Кроме файла в папке `templated_configs`, для использования внутри dbt также создается макрос, который возвращает содержимое конфига.
## Порядок работы
### Подготовительная работа
Проверяем, что в проекте dbt существует папка `templated_configs`, а если не существует — создаем ее.
### Список для итерации
Все конфиги, которые в таблице [[Configs#Список конфигов]] помечены как `templated_file`, независимо от значения метаконфигов.
### Формат результата на шаге `prepare`
```
[{"name": "connectors", "source": "file", "file_path": "/path/to/etlcraft/templated_configs/connectors.yml", "format": "yml", "symlink": false},
{"name": "presets", "source": "file", "file_path": "presets_manual.yml", "format": "json", "symlink": "true"},
{"name": "metadata", "source": "airflow_variable", "variable_name": "my_metadata", "format": "yml"},
...
]
```
### Работы на шаге `prepare`
- Значение `format` берем из метаконфига, если есть.
- Если в метаконфиге `source == "other_variable"`, то в `source` прописываем `airflow_variable`.
- `source == "datacraft_variable"` не поддерживается, поэтому генерируем ошибку при такой комбинации.
- В противном случае устанавливаем `source` в `file`.
- Если в метаконфиге `source == "file"`, то `source` берем из пути метаконфига. 
- Для `source == "templated_file"`, то смотрим наличие файла  `{название конфига}_manual.{format}`, если он существует — берем его в качестве `file` и ставим `symlink` в `true`, если нет, то `{путь до пакета etlcraft}/templated_files/{название конфига}{путь из метаконфига, если есть}{.format}` и `symlink` в `false`.
### Работы во время итерации
1. Удаляем в папке `templated_files` проекта dbt файл с названием `{name}.{format}`.
2. Если `source == "airflow_variable"`, то копируем значение соответствующей переменной в файл `{name}.{format}`.
3. Если `source == "file"` и `symlink == false`, то копируем файл `file_path` в `{name}.{format}`. Если же `symlink == true`, то делаем символическую ссылку вместо копирования.
4. В папке `macros/templated_files` проекта dbt создаем файл `{название конфига}.sql` по шаблону:
```
{%- macro название_конфига_data() -%}
содержимое файла, созданного выше
{%- endmacro -%}

{%- macro название_конфига() -%}
fromyaml или fromjson(название_конфига_data())
{%- endmacro -%}
```
## Порядок запуска
DAG запускается перед запуском всех остальных DAG’ов, так как его работа влияет на них через функцию `get_configs(...)` (см. [[Configs#Конфигурация#Функция `get_configs(...)`]]).