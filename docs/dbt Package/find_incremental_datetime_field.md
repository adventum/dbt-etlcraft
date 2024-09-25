---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize, incremental
doc_status: ready
---
# macro `find_incremental_datetime_field`

## Описание

Этот макрос находит инкрементальное поле даты и времени.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
column_list, relation, defaults_dict=etlcraft.etlcraft_defaults(), do_not_throw=False
```
## Функциональность

Макрос получает в качестве аргумента `relation`, где начинает поиск. Для этого макрос разбивает название на части, и при помощи вспомогательного макроса [[get_from_default_dict]] ищет поле/поля, которые оканчиваются на:
- `date`
- `datetime`
- `period_start`
- `timestamp`
- `_time`

Если не найдено ни одного поля, или если найдено несколько полей вместо одного, макрос выдаст ошибку.

Результатом работы макроса является возвращение найденного поля.
