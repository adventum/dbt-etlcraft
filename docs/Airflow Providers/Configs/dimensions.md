---
description: Описание разбивок для моделей атрибуции.
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: ready (нужно ревью)
---

# Описание

Данный конфиг содержит:
- `slug` - идентификатор поля разбивки (см. [[Slug]]),
- `name` - русское название (см. [[Name (config)|Name]]),
- `descripton` - описание поля.

В пакете **dataCraft Core** в папке `templated_configs` содержится базовая версия данного конфига. Данные из него используются для формирования раздела `attributable_parameters` в моделях атрибуции, задаваемых через интерфейс **dataCraft** (подробнее см. [[attributions]]). 

Механизм следующий: данные подтягиваются в **dataCraft**, при задании пользователем модели атрибуции пользователь выбирает необходимые разбивки на основе русских названий `name`,  а в конфиг [[attributions]] записывается `slug`. 
# Пример 
```yaml
adSourceClear:
	name: Чистый источник
	description: какое-то описание
utmCampaign:
	name: UTM-кампания
	description: какое-то описание
```
