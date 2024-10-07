---
category: sub_main
step: 4_graph
sub_step: 2_lookup
in_main_macro: graph
doc_status: ready
---
# macro `graph_lookup`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "graph_lookup")
SORT doc_status
```
## Описание

Это второй шаг макроса `graph`. После завершения работы `graph_tuples`, `graph_lookup` использует результаты этого макроса для создания временной таблицы, содержащей ключи и метаданные, необходимые для дальнейших шагов.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params=none,
  stage_name=none,
  limit0=none
```
## Функциональность

Макрос настраивает материализацию данных: устанавливает порядок сортировки данных по ключевому номеру.

Сначала происходит создание временной таблицы с уникальными ключами: выбор уникальных хэшей из результатов макроса graph_tuples и объединение их с уникальными узлами.

Затем происходит выборка всех ключей и присвоение им номера. 

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `graph_lookup`

Содержимое файла:
```sql
-- depends_on: {{ ref('graph_tuples') }}

{{ datacraft.graph() }}
```
