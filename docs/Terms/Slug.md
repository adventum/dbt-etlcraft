---
term_name: slug
description: короткое латинское название без пробелов. Если не сказано иное, slug не должен содержать знаков `_` или `*-*`, то есть ничего, кроме латинских букв и цифр
type: term
doc_status: ready (нужно ревью)
---
В методологии **dataCraft Core** используется три уровня идентификации объектов:
* Slug
* [[Id]]
* [[Name (config)]]

**Slug** — это короткое, читабельное, уникальное текстовое представление объекта. Используется для идентификации объектов в [[Configs]].

**Характеристики**:
- Состоит из латинских букв и цифр, не допускается использование пробелов и специальных знаков. В некоторых случаях допускается использование нижнего подчёркивания. 
- Требует уникальности в рамках определённого конфига.
- Может быть изменён пользователем или администратором.

**Пример использования:**
Например, в конфиге [[attributions]] в разделе `priorities` приводится список `slug`’ов:
```jsx
<...>
      "priorities": [
        "eventsegment1",
        "eventsegment2",
        "eventsegment3",
        "eventsegment4"
      ],
<...>
```
А в конфиге [[event_segments]] приводится подробное описание этих элементов:
```
eventsegment1:
  formula: LENGTH (adSourceDirty) < 2
  description: тут какое-то описание
eventsegment2:
  formula: match(adSourceDirty, 'Органическая установка')
  description:
eventsegment3:
  formula: __priority = 4 and not __if_missed = 1
  description:
eventsegment4:
  formula: __priority = 3 and not __if_missed = 1
  description:
```
Благодаря `slug` эти данные можно сопоставить и дополнить данные из [[attributions]] данными из [[event_segments]].