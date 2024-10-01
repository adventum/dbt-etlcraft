---
description: Правила расчета моделей атрибуций
config_default_type: "`datacraft_variable`"
config_default_format: "`json`"
type: config
doc_status: in progress
---
# Описание

Модель атрибуции представляет собой правило или набор правил, по которым источнику данных присваивается ценность (степень его вклада в конверсию).

В **dataCraft** можно задать модель атрибуции, которая будет использоваться при обработке данных. Это реализуется в разделе **Данные**: 
![[add_attr_model_in_dataCraft_example.jpg]]

На основе введённых данных формируется конфиг с описанием модели в формате json.
Для каждой модели конфиг содержит:
- название модели
- `description` - описание модели (опционально)
- `model_type` - тип модели. В настоящий момент доступны два:
	- First click - “По первому взаимодействию” 
	- Last click - “По последнему взаимодействию”
- `attributable_parameters` - разбивки, для которых будет рассчитываться атрибуция (например: название источника данных, название рекламной кампании и т.д.) 
-  `funnel_steps` - шаги воронки
- для типа Last click также можно указать `priorities` - список названий правил присвоения приоритета. Сами правила прописаны в [[metadata]] 

Данный конфиг используется для формирования файлов моделей в DAG’е [[generate_models]], а также определяет макрос `attribution_models`, необходимый для работы макроса [[attr]] в [[dbt Package|пакете dbt]].
#task создать файл с описанием макроса attribution_models и добавить на него ссылку

# Пример
```jsx
{
  "attribution_models": {
    "my_first_attr_model": {
      "description": "описание 1",
      "model_type": "last_click",
      "priorities": [
        "event_segment_1",
        "event_segment_2",
        "event_segment_3",
        "event_segment_4"
      ],
      "attributable_parameters": [
        "utmSource",
        "utmMedium",
        "utmCampaign",
        "utmTerm",
        "utmContent",
        "adSourceDirty"
      ],
      "funnel_steps": [
        {
          "slug": "visits_step",
          "timeout": 14
        },
        {
          "slug": "install_step",
          "timeout": 14
        },
        {
          "slug": "app_visits_step",
          "timeout": 14
        },
        {
          "slug": "event_step",
          "timeout": 14
        }
      ]
    },
    "my_second_attr_model": {
      "description": " ",
      "model_type": "first_click",
      "attributable_parameters": [
        "utmSource",
        "utmMedium",
        "utmCampaign"
      ],
      "funnel_steps": [
        {
          "slug": "visits_step",
          "timeout": 14
        },
        {
          "slug": "install_step",
          "timeout": 14
        }
      ]
    }
  }
}
```
