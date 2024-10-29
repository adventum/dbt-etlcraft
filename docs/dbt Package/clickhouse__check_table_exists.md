---
category: auxiliary
step: 5_full
in_main_macro: full
doc_status: ready
---
# macro `clickhouse__check_table_exists`

## Описание

Макрос проверяет, существует ли заданная в аргументе таблица.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
source_table,database
```
## Функциональность

Макрос создаёт и затем выполняет простой тестовый запрос к `system.tables`. 

Если таблица есть, макрос возвращает 1, если нет - возвращает 0.

