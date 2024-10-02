---
description: 
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: in progress
---
#task тут всё таки уточнить для чего нужны разбивки как отдельный конфиг, если мы задаём их в атрибуции или в атрибуции просто список, а тут подробное описание??

# Описание


Эти данные добавляются в проект с помощью DAG’а [[template_configs]].
# Пример 
```yaml
- 1:
	name: чистый источник
	field: adSourceClear
	description: какое-то описание
- 2:
	name: UTM-кампания
	field: utmCampaign
	description: какое-то описание
```
