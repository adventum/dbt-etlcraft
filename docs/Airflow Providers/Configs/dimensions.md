---
description: 
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: in progress
---

# Описание

Это будет подтягиваться в dataCraft, чтобы пользователь мог накликать при задании моели атрибуции

Эти данные добавляются в проект с помощью DAG’а [[template_configs]].
# Пример 
```yaml
adSourceClear:
	name: Чистый источник
	description: какое-то описание
- 2:
	name: UTM-кампания
	field: utmCampaign
	description: какое-то описание
```
