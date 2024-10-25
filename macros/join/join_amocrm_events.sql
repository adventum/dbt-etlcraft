{%- macro join_amocrm_events(
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params,
    limit0=none
    ) -%}

{{ config(
    materialized='incremental',
    order_by=('__date', '__table_name'),
    incremental_strategy='delete+insert',
    unique_key=['__date', '__table_name'],
    on_schema_change='fail'
) }}

{%- if execute -%}
{#- задаём общие части имени -#}
{%- set sourcetype_name = 'amocrm' -%}
{%- set pipeline_name = 'events' -%} 
{%- set pipeline_name_registry = 'registry' -%}

{#- для каждого стрима собираем инкрементал-таблицы и создаём свой source_table_<...> -#}
{#- стрим events -#}
{%- set table_pattern_events = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'events' ~ '$' -%}
{%- set relations_events = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_events) -%}   
{%- if not relations_events -%} 
    {{ exceptions.raise_compiler_error('No relations_events.
    No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_events"') }}
{%- endif -%}
{%- set source_table_events = '(' ~ dbt_utils.union_relations(relations_events) ~ ')' -%}  
{%- if not source_table_events -%} 
    {{ exceptions.raise_compiler_error('No source_table_events.
    Macro dbt_utils.union_relations fetches no data from relations_events') }}
{%- endif -%}

{#- стрим leads -#}
{%- set table_pattern_leads = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'leads' ~ '$' -%}
{%- set relations_leads = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_leads) -%}   
{%- if not relations_leads -%} 
    {{ exceptions.raise_compiler_error('No relations_leads. 
    No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_leads"') }}
{%- endif -%}
{%- set source_table_leads = '(' ~ dbt_utils.union_relations(relations_leads) ~ ')' -%}    
{%- if not source_table_leads -%} 
    {{ exceptions.raise_compiler_error('No source_table_leads.
    Macro dbt_utils.union_relations fetches no data from relations_leads') }}
{%- endif -%}

{#- стрим contacts -#}
{%- set table_pattern_contacts = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name ~  '_[^_]+_' ~ 'contacts' ~ '$' -%}
{%- set relations_contacts = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_contacts) -%}   
{%- if not relations_contacts -%} 
    {{ exceptions.raise_compiler_error('No relations_contacts. 
    No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name}_{template_name}_contacts"') }}
{%- endif -%}
{%- set source_table_contacts = '(' ~ dbt_utils.union_relations(relations_contacts) ~ ')' -%}    
{%- if not source_table_contacts -%} 
    {{ exceptions.raise_compiler_error('No source_table_contacts.
    Macro dbt_utils.union_relations fetches no data from relations_contacts') }}
{%- endif -%}

{#- стрим pipelines -#}
{%- set table_pattern_pipelines = 'incremental_' ~ sourcetype_name ~ '_' ~ pipeline_name_registry ~  '_[^_]+_' ~ 'pipelines' ~ '$' -%}
{%- set relations_pipelines = etlcraft.get_relations_by_re(schema_pattern=target.schema, table_pattern=table_pattern_pipelines) -%}   
{%- if not relations_pipelines -%} 
    {{ exceptions.raise_compiler_error('No relations_pipelines. 
    No data follows the expected pattern: "incremental_{sourcetype_name}_{pipeline_name_registry}_{template_name}_pipelines"') }}
{%- endif -%}
{%- set source_table_pipelines = '(' ~ dbt_utils.union_relations(relations_pipelines) ~ ')' -%}    
{%- if not source_table_pipelines -%} 
    {{ exceptions.raise_compiler_error('No source_table_pipelines.
    Macro dbt_utils.union_relations fetches no data from relations_pipelines') }}
{%- endif -%}

{#- для каждого стрима создаём его CTE -#}

{#- стрим events - Список событий – набор информации о происходящих действиях в аккаунте. -#}
with events as (
select  --__date, --дата, берётся из created_at на normalize
id as eventId, --ID события
type as eventType, --Тип события 
toInt64(entity_id) as entityId, --ID сущности события
entity_type as entityType, --Сущность события
toInt64(created_by) as eventCreatedBy, -- ID пользователя, создавший событие
--ВОПРОС СОХРАНЯТЬ ЛИ ВРЕМЯ ИЛИ ДОСТАТОЧНО ДАТЫ? и нужно ли в UTC или нет? utc нужно, и осталвяем дату и время 
toDateTime(created_at) as eventCreatedAtDateTime, -- Дата создания события, передается в Unix Timestamp
value_after as valueAfter, -- Массив с изменениями по событию.
value_before as valueBefore, -- Массив с изменениями по событию.
--нужно ли тоже указывать что это аккаунт события, т.е. давать название eventAccountId? (то же в contacts) 
toInt64(account_id) as systemAccountId, --ID аккаунта, в котором находится событие
--в entityType указано к чему относится событие (task, lead, contact, talk, customer, company), а в entityId соответствующий id 
--в отдельные столбецы вытащим id сделки и id контакта (при необходимости можно добавить будет остальные)
case when entity_type = 'lead' THEN toInt64(entity_id) end as leadId,
case when entity_type = 'contact' then toInt64(entity_id) end as contactId,
-- получаем из valueAfter id актуального статуса сделки и id воронки 
case 
	when type = 'lead_status_changed' then toInt64(JSON_VALUE(value_after, '$[0].lead_status.id'))
end as statusId, -- ID статуса (соответствует statusId из стрима pipeliens)
case 
	when type = 'lead_status_changed'  then toInt64(JSON_VALUE(value_after, '$[0].lead_status.pipeline_id'))
end as pipelineId, -- ID воронки (соответствует pipelineId из стрима pipelines)
JSONExtractString(JSONExtractString(_links, 'self'), 'href') as crmSystemLinkForEvents,
-- технические поля
toLowCardinality('CrmEventStat') AS __link, --поле из методологии dataCraft Core (нужно для последующих шагов hash, link)
toLowCardinality(__table_name) as __table_name,
__emitted_at, -- дата и время выгрузки данных
__normalized_at -- дата и время проведения нормализации (т.е. шага normalize)
from {{ source_table_events }}
-- отберём только интересующие нас события (пока отбираем только связанные со сделками и контактам)
where type in ['lead_status_changed', 'lead_deleted', 'lead_added', 'contact_added']
)

{#- стрим leads - содержит данные по сделкам -#}
, leads as (
select  --__date, --дата, берётся из created_at на NORMALIZE (нужна только дата события, дата создания сделки в поле leadCreatedAtDate)
toInt64(id) as leadId, -- ID сделки
name as leadName, -- Название сделки
price as price, -- Бюджет сделки (в старой версии это поле назыалось sale)
toInt64(responsible_user_id) as leadResponsibleUserId, -- ID пользователя, ответственного за сделку
toInt64(group_id) as leadGroupId, -- ID группы, в которой состоит ответственны пользователь за сделку
toInt64(status_id) as leadLastStatusId, -- ID статуса, в который добавляется сделка, по-умолчанию – первый этап главной воронки (соответствует id в _embedded[statuses] в стриме pipelines)
toInt64(pipeline_id) as leadLastPipelineId, -- ID воронки, в которую добавляется сделка
toInt64OrZero(loss_reason_id) as leadlossReasonId,  -- ID причины отказа
toInt64OrZero(source_id) as leadSourceId,  --ID источника сделки 
toInt64(created_by) as leadCreatedBy, -- ID пользователя, создающий сделку
toInt64(updated_by) as leadUpdatedBy, -- ID пользователя, изменивего сделку
--НУЖНО В UTC (сначала проверить как api отдаёт данные)
toDateTimeOrZero(closed_at) as leadClosedAtDate, -- Дата закрытия сделки, передается в Unix Timestamp
toDateTime(created_at) as leadCreatedAtDate, -- Дата создания сделки, передается в Unix Timestamp
toDateTime(updated_at) as leadUpdateddAtDate, -- Дата изменения сделки, передается в Unix Timestamp
toDateTimeOrZero(closest_task_at) as leadClosestTaskAt, --Дата ближайшей задачи к выполнению, передается в Unix Timestamp
is_deleted as leadIsDeleted, -- Удалена ли сделка
-- custom_fields_values - Массив, содержащий информацию по значениям дополнительных полей, заданных для данной сделки (уточнить какие ещё данные тут могут быть нужны)
--UTM_CONTENT 
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%UTM_CONTENT%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as utmContent,
--UTM_SOURCE 
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%UTM_SOURCE%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as utmSource,
--UTM_MEDIUM 
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%UTM_MEDIUM%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as utmMedium,
--UTM_TERM
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%UTM_TERM%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as utmTerm,
--UTM_CAMPAIGN
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%UTM_CAMPAIGN%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as utmCampaign,
--SIPUNI_NUM
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%SIPUNI_NUM%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as sipuniNum,
--_YM_COUNTER
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%_YM_COUNTER%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as ymCounter,
--_YM_UID
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%_YM_UID%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as ymUID,
--GCLIENTID
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%GCLIENTID%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as gClientId,
--ZOOM_LINK
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%ZOOM_LINK%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as zoomLink, 
--ROISTAT
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%ROISTAT%', 
JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as roiStat,
toInt64OrNull(score) as leadScore, -- Скоринг сделки
toInt64(account_id) as systemAccountId, -- ID аккаунта, в котором находится сделка
toInt64OrZero(labor_cost) as leadLaborCost, -- Тип поля "стоимость труда" показывает сколько времени было затрачено на работу со сделкой. Время исчисления в секундах
is_price_modified_by_robot as isPriceModifiedByRobot, -- Изменен ли в последний раз бюджет сделки роботом
-- _embedded - Данные вложенных сущностей. Нужны только данные по loss_reason (на всякий случай оставила ещё companyId) 
-- _embedded[loss_reason] - Причина отказа сделки
JSONExtractString(JSONExtractArrayRaw(_embedded, 'loss_reason')[1], 'name')  as leadLossReasonName, -- Название причины отказа
-- _embedded[contacts] - Данные контактов, привязанных к сделке (у одной сделки может быть указано более 1 контакта)
-- для соединения данных по лидам и контактам (из стрима contacts) будет использоваться отдельная табличка LeadContactMatching (её делаю отдельно из массива _embedded[contacts])
--
--_embedded[companies] - Данные компании, привязанной к сделке, в данном массиве всегда 1 элемент, так как у сделки может быть только 1 компания
JSONExtractString(JSONExtractArrayRaw(_embedded, 'companies')[1], 'id')  as leadCompanyId, -- ID компании, привязанной к сделке
JSONExtractString(JSONExtractString(_links, 'self'), 'href') as crmSystemLinkForLeads
--технические поля, в финальную таблицу шага join идут данные из основной таблицы, к которой приджойниваем, т.е. в нашем случае из events
--toLowCardinality('CrmEventStat') AS __link, --поле из методологии dataCraft Core (нужно для последующих шагов hash, link)
--toLowCardinality(__table_name) as __table_name,
--__emitted_at, -- дата и время выгрузки данных
--__normalized_at -- дата и время проведения нормализации (т.е. шага normalize)
from {{ source_table_leads }}
)

{#- стрим contacts - данные по контактам -#}
, contacts as (
select -- __date, --дата, берётся из created_at на NORMALIZE (нужна только дата события, дата создания контакта в поле contactCreatedAtDate)
toInt64(id) as contactId, --ID контакта
name as contactName, --Название контакта
first_name as firstName, --Имя контакта
last_name as lastName, --Фамилия контакта
-- custom_fields_values - Массив, содержащий информацию по значениям дополнительных полей, заданных для данного контакта
-- для телефона и email получаем вот так, так как может быть указано несколько значений: 
--ТЕЛЕФОН
arrayMap(x -> JSONExtractString(x, 'value'), 
	JSONExtractArrayRaw(JSONExtractString(
		arrayFilter(x -> x LIKE '%PHONE%', JSONExtractArrayRaw(custom_fields_values))[1],'values'))) AS phoneNumbers,
arrayMap(x -> JSONExtractString(x, 'enum_code'),
--code: Доступные значения для поля Телефон: WORK – рабочий, WORKDD – рабочий прямой, MOB – мобильный, FAX – факс, HOME – домашний, OTHER – другой.
	JSONExtractArrayRaw(JSONExtractString(
		arrayFilter(x -> x LIKE '%PHONE%', JSONExtractArrayRaw(custom_fields_values))[1],'values'))) AS phoneCodes,
--EMAIL
arrayMap(x -> JSONExtractString(x, 'value'), 
	JSONExtractArrayRaw(JSONExtractString(
		arrayFilter(x -> x LIKE '%EMAIL%', JSONExtractArrayRaw(custom_fields_values))[1],'values'))) AS email,
arrayMap(x -> JSONExtractString(x, 'enum_code'), 
--code: Доступные значение для поля Email: WORK – рабочий, PRIV – личный, OTHER – другой.
	JSONExtractArrayRaw(JSONExtractString(
		arrayFilter(x -> x LIKE '%EMAIL%', JSONExtractArrayRaw(custom_fields_values))[1],'values'))) AS emailCodes,
-- для пола и возраста чуть-чуть подругому, так как не может быть два значения (по логике)
--Пол
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%Пол%', JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as gender,
-- Возраст
JSONExtractString(JSONExtractArrayRaw(arrayFilter(x -> x LIKE '%Возраст%', JSONExtractArrayRaw(custom_fields_values))[1], 'values')[1], 'value') as age,
toInt64(responsible_user_id) as contactResponsibleUserId, --ID пользователя, ответственного за контакт УТОЧНИТЬ ПРО НЕЙМИНГ ПОЛЯ!!!! 
toInt64(group_id) as contactGroupId, --ID группы, в которой состоит ответственны пользователь за контакт
toInt64(created_by) as contactCreatedBy, -- ID пользователя, создавший контакт --ОК НАЗВАНИЕ???
toInt64(updated_by) as contactUpdatedBy, --ID пользователя, изменивший контакт
--ВОПРОС СОХРАНЯТЬ ЛИ ВРЕМЯ ИЛИ ДОСТАТОЧНО ДАТЫ? и нужно ли указывать UTC или нет? в UCT и оставляем дату и время
toDateTime(created_at) as contactCreatedAtDate, -- Дата создания контакта, передается в Unix Timestamp 
toDateTime(updated_at) as contactUpdateddAtDate, -- Дата изменения контакта, передается в Unix Timestamp
is_deleted as contactIsDeleted, -- Удален ли элемент
toDateTimeOrZero(closest_task_at) as contactClosestTaskAt, --Дата ближайшей задачи к выполнению, передается в Unix Timestamp
toInt64(account_id) as systemAccountId, -- ID аккаунта, в котором находится контакт
-- _embedded - Данные вложенных сущностей
--_embedded[companies] - Данные компании, привязанной к контакту. В массиве всегда 1 объект (НУЖНО УТОЧНИТЬ НУЖНЫ ЛИ ЭТИ ДАННЫЕ - не нужны)
JSONExtractString(JSONExtractArrayRaw(_embedded, 'companies')[1], 'id')  as contactCompanyId, -- ID компании, привязанной к контакту
-- в _embedded[leads] - Данные сделок, привязанных к контакту. Одному контакту может соответствовать несколько сделок.
-- для соединения данных (и если будет нужны графовая склейка) по лидам и контактам будет использоваться отдельная табличка LeadContactMatching (её я получаю из массива _embedded[contacts] стрима leads)
JSONExtractString(JSONExtractString(_links, 'self'), 'href') as crmSystemLinkForContacts 
--технические поля, в финальную таблицу шага join идут данные из основной таблицы, к которой приджойниваем, т.е. в нашем случае из events
--toLowCardinality('CrmEventStat') AS __link, --поле из методологии dataCraft Core (нужно для последующих шагов hash, link)
--toLowCardinality(__table_name) as __table_name,
--__emitted_at,
--__normalized_at
from {{ source_table_contacts }}
),
--
-- стрим pipelines - содержит информацию по воронкам и шагам воронок (статусам) 
pipelines as (
select  toInt64(id) as pipelineId, --ID воронки
name as pipelineName, -- Название воронки
toInt8(sort) as pipelineSort, -- Сортировка воронки
is_main as pipelineIsMain, -- Является ли воронка главной
is_unsorted_on as pipelineIsUnsortedOn, -- Включено ли неразобранное в воронке
is_archive as pipelineIsArchive, -- Является ли воронка архивной
toInt64(account_id) as systemAccountId, -- ID аккаунта, в котором находится воронка
-- _embedded[statuses] - Данные статусов, имеющихся в воронке.
toInt64(JSONExtractString(arrayJoin(JSONExtractArrayRaw(_embedded, 'statuses')), 'id')) as statusId, --(соотв. leadStatusId в стриме leads)
JSONExtractString(arrayJoin(JSONExtractArrayRaw(_embedded, 'statuses')), 'name') as statusName,
JSONExtractString(arrayJoin(JSONExtractArrayRaw(_embedded, 'statuses')), 'sort') as statusSort,
JSONExtractString(arrayJoin(JSONExtractArrayRaw(_embedded, 'statuses')), 'is_editable') as statusIsEditable,
JSONExtractString(arrayJoin(JSONExtractArrayRaw(_embedded, 'statuses')), 'type') as statusType,
JSONExtractString(JSONExtractString(JSONExtractString(arrayJoin(JSONExtractArrayRaw(_embedded, 'statuses')), '_links'), 'self'), 'href') as crmSystemLinkForStatus,
JSONExtractString(JSONExtractString(_links, 'self'), 'href') as crmSystemLinkForPipelines
--технические поля, в финальную таблицу шага join идут данные из основной таблицы, к которой приджойниваем, т.е. в нашем случае из events
--toLowCardinality('CrmEventStat') AS __link, --поле из методологии dataCraft Core (нужно для последующих шагов hash, link)
--toLowCardinality(__table_name) as __table_name,
--__emitted_at,
--__normalized_at
from {{ source_table_pipelines }}
)

{#- теперь делаем join записанных ранее CTE -#}
, final_join AS (
eventCreatedAtDateTime AS __datetime,
* --count(*) 
from events as e
left join leads as l USING(leadId, systemAccountId) 
left join pipelines as p USING(statusId, pipelineId, systemAccountId) 
left join contacts as c using(contactId, systemAccountId) 
)
SELECT *
FROM final_join
{% if limit0 %}
LIMIT 0
{%- endif -%}

{%- endif -%}
{% endmacro %}