---
description: Источники данных, на каждый из которых в Airbyte нужно настроить Source и Destination
config_default_type: "`datacraft_variable`"
config_default_format: "`json`"
type: config
doc_status: in progress
---
# Описание


# Пример

```jsx
{
    "datasources": {
        "13": {
            "source_type": "yd",
            "account_name": "adventum-client2",
            "project": "datacraft",
            "preset": "yd_default", 
            "init_status": "untested",
            "source_class": "ads_cabinet"
        },
        "14": {
            "source_type": "ym",
            "account_name": "adventum-client2",
            "project": "datacraft",
            "preset": "ym_default", 
            "init_status": "untested",
            "source_class": "ads_cabinet"
        },
		"15": {
            "source_type": "appmetrica",
            "account_name": "adventum-client2",
            "project": "datacraft",
            "preset": "appmetrica_default", 
            "init_status": "untested",
            "source_class": "ads_cabinet"
        }
    }
}
```
#task актуализировать пример раздела datasources 