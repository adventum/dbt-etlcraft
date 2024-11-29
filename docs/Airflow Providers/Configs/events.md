---
description: Правила определений событий, которые используются в атрибуции и воронке
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
type: config
doc_status: ready (нужно ревью)
---
# Описание

Данный конфиг содержит описание базовых, наиболее часто встречающихся в данных, событий воронки. В это описание входят:
- slug - идентификатор события, например: visits_step
- link - название [[Terms/Link|линка]], к которому относятся данные этого шага. Необходимо, чтобы понимать откуда брать, из каких полей, данные для этого шага 
- datetime_field - поле, в котором хранится дата и время по этому событию
- condition - дополнительное условие, которое должно выполнятся, чтобы событие можно было отнести к этому шагу (записывается как кусок SQL кода, так как с помощью макроса [[attr_create_events]]] будет подставляться в запрос)
- if_missed - флаг, который указывается, если шаг был пропущен
  
Данные из `events`, в комбинации с данными из конфига [[attributions]],  используются: 
1) для определения шаг воронки для каждой строки при обработке данных с помощью [[dbt Package]] на шаге атрибуции;
2) для визуализации воронки в **dataCraft**.

При первом варианте использования данные конфига добавляются в проект с помощью DAG’а [[template_configs]]. 

При втором варианте использования данные из этого конфига передаются в **dataCraft** c помощью специальной переменной `for_datacraft`. За формирование этой переменной отвечает отдельный DAG - `sync_configs`. 

В пакете **dataCraft Core** в папке `templated_configs` содержится базовая версия данного конфига, при необходимости его можно кастомизировать.
# Пример 
```yaml
visits_step:
  - link: VisitStat
	datetime_field: __datetime
	condition: osName = 'web'
	if_missed: '[Без веб сессии]'
install_step:
  - link: AppInstallStat
	datetime_field: __datetime
	condition: installs >= 1
	if_missed: '[Без установки]'
app_visits_step:
  - link: AppSessionStat
	datetime_field: __datetime
	condition: sessions >= 1
	if_missed: '[Без апп сессии]'
  - link: AppDeeplinkStat
	datetime_field: __datetime
	if_missed: '[Без апп сессии]'
event_step:
  - link: AppEventStat
	datetime_field: __datetime
	condition: screenView >= 1
```
