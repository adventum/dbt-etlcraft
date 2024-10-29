---
category: auxiliary
step: 2_staging
sub_step: 1_join
language: rus
in_sub_main_macro: join_ym_events
doc_status: ready
---
# macro `get_adsourcedirty`

## Описание

Этот макрос нужен для работы с данными utm-меток - при помощи передаваемых аргументов макрос возвращает название источника перехода.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
utm_source='utmSource', utm_medium='utmMedium'
```
## Функциональность

Действие макроса - если `utm_source` не пустой, он соединит передаваемые значения аргументов:
```sql
lower(if(length({{ utm_source }}) > 0, concat({{ utm_source }}, ' / ', {{ utm_medium }}), null))
```
