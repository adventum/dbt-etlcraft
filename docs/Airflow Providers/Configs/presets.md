---
description: Конфигурации Airbyte Source, Destination и Connection, которые используются при создании нового источника
config_default_type: "`templated_file`"
config_default_format: "`yaml`"
---
# Описание

[[Написать инструкцию, как сформировать конфиг для presets]]

Конфиг состоит из трех разделов. Во всех разделах внутри пресета присутствуют разделы:

- entities
- links

directintegration_presets: сведения о прямых интеграциях. Ключ: slug для прямой интеграции, значения:

- schema
- table
- fields

[Прямая интеграция](../../../%D0%A2%D0%B5%D1%80%D0%BC%D0%B8%D0%BD%D1%8B%20dbac8779132248adb2d7319ad5c22682/Untitled%20Database%202689837760d84646b63d8655e9299354/%D0%9F%D1%80%D1%8F%D0%BC%D0%B0%D1%8F%20%D0%B8%D0%BD%D1%82%D0%B5%D0%B3%D1%80%D0%B0%D1%86%D0%B8%D1%8F%201bf59834fbc1446f84c692a95a431a1b.md)

# Пример

```jsx
{   "directintegration_presets": {
    "example1": {
        "schema": "название схем в кликхаусе",
        "table": "название таблицы",
        "fields": ["field1", "field2", "field3"],
        "entities": ["entity1", "entity2"] 
    }       
        },
"source_presets": {
    "appmetrica_default":
    {
        "connectionId": "*****",
        "name": "appmetrica_default_ → default",
        "namespaceDefinition": "destination",
        "namespaceFormat": "${SOURCE_NAMESPACE}",
        "prefix": "appmetrica_default_",
        "sourceId": "******",
        "destinationId": "*****",
        "entities": ["Account", 
            "AdSource",
            "UtmParams",
            "UtmHash",
            "CrmUser",
            "PromoCode",
            "City",
            "MobileAdsId",
            "OsName",
            "Transaction",
            "AppMetricaDevice",
            "AppMetricaDeviceId",
            "AppSession"],
        "links": ["AppEventStat", 
            "AppDeeplinkStat",
            "AppProfileMatching",
            "AppInstallStat"],         
        "syncCatalog": {
            "streams": [
                {
                    "stream": {
                        "name": "events",
                        "pipeline": "events",
                        "jsonSchema": {
                            "$schema": "http://json-schema.org/draft-07/schema#",
                            "type": "object",
                            "properties": {
                                "google_aid": {
                                    "type": [
                                        "null",
                                        "string"
                                    ]
                                },
                                **...**
                        },
                        "supportedSyncModes": [
                            "full_refresh"
                        ],
                        "sourceDefinedCursor": false,
                        "defaultCursorField": [],
                        "sourceDefinedPrimaryKey": []
                    },
                    "config": {
                        "syncMode": "full_refresh",
                        "cursorField": [],
                        "destinationSyncMode": "overwrite",
                        "primaryKey": [],
                        "aliasName": "events",
                        "selected": true,
                        "suggested": false,
                        "fieldSelectionEnabled": false,
                        "selectedFields": []
                    }
                },
                
            ]
        },
        "scheduleType": "manual",
        "status": "active",
        "operationIds": [],
        "source": {
            "sourceDefinitionId": "*****",
            "sourceId": "*****",
            "workspaceId": "*****",
            "connectionConfiguration": {
                "sources": [
                    {
                        "fields": [
                            "event_datetime",
                            "event_json",
                            "event_name",
                            "installation_id",
                            "appmetrica_device_id",
                            "city",
                            "google_aid",
                            "os_name",
                            "profile_id",
                            "session_id",
                            "app_version_name",
                            "ios_ifa"
                        ],
                    
                ],
                "date_range": {
                    "date_range_type": "last_n_days",
                    "last_days_count": 7,
                    "should_load_today": false
                },
                "credentials": {
                    "auth_type": "credentials_craft_auth",
                    "credentials_craft_host": "*****",
                    "credentials_craft_token": "**********",
                    "credentials_craft_token_id": "**"
                },
                "chunked_logs": {
                    "split_mode_type": "do_not_split_mode"
                },
                "application_id": "*****"
            },
            "name": "appmetrica_default_",
            "sourceName": "appmetrica",
            "isVersionOverrideApplied": false,
            "supportState": "supported"
        },
        "destination": {
            "destinationDefinitionId": "*****",
            "destinationId": "*****",
            "workspaceId": "*****",
            "connectionConfiguration": {
                "ssl": false,
                "host": "*****",
                "port": "*****",
                "database": "*****",
                "password": "**********",
                "tcp-port": 9000,
                "username": "*****",
                "tunnel_method": {
                    "tunnel_method": "NO_TUNNEL"
                }
            },
            "name": "default",
            "destinationName": "Clickhouse",
            "icon": "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"250\" height=\"250\" fill=\"none\"><g clip-path=\"url(#a)\"><path fill=\"red\" d=\"M29.01 189.5h21.33V211H29.01v-21.5Z\"/><path fill=\"#FC0\" d=\"M29.01 39h21.332v150.5H29.01V39Zm42.663 0h21.331v172h-21.33V39Zm42.663 0h21.331v172h-21.331V39Zm42.662 0h21.331v172h-21.331V39Zm42.662 69.875h21.332v32.25H199.66v-32.25Z\"/></g><defs><clipPath id=\"a\"><path fill=\"#fff\" d=\"M29 39h192v172H29z\"/></clipPath></defs></svg>",
            "isVersionOverrideApplied": false,
            "supportState": "supported"
        },
        "operations": [],
        "latestSyncJobCreatedAt": 1719228335,
        "latestSyncJobStatus": "succeeded",
        "isSyncing": false,
        "catalogId": "cadd2973-80cd-459a-aee9-c4094cedfd3e",
        "geography": "auto",
        "schemaChange": "no_change",
        "notifySchemaChanges": false,
        "notifySchemaChangesByEmail": false,
        "nonBreakingChangesPreference": "propagate_fully",
        "createdAt": 1716213516,
        "backfillPreference": "disabled",
        "sourceActorDefinitionVersion": {
            "dockerRepository": "adventum/source-appmetrica-logs-api",
            "dockerImageTag": "0.4.1",
            "supportsRefreshes": false,
            "isVersionOverrideApplied": false,
            "supportLevel": "none",
            "supportState": "supported"
        },
        "destinationActorDefinitionVersion": {
            "dockerRepository": "airbyte/destination-clickhouse",
            "dockerImageTag": "1.0.0",
            "supportsRefreshes": false,
            "isVersionOverrideApplied": false,
            "supportLevel": "community",
            "supportState": "supported"
        }
    },
    "ym_default":

}
}

```