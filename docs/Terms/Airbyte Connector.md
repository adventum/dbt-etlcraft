---
term_name: Коннектор
description: докер-образ, который используется в Airbyte для скачивания или загрузки данных
type: term
doc_status: ready (нужно ревью)
---
**Airbyte Connector** — это программный компонент, который реализует интерфейсы для взаимодействия либо с источником данных ([[Airbyte Source]]), либо с целевой системой [[Airbyte Destination]]. Коннекторы делятся на два типа:

1. **Source Connector** (Коннектор источника) — извлекает данные из внешнего источника.
2. **Destination Connector** (Коннектор целевой системы) — загружает данные в целевое хранилище.

Каждый коннектор имеет свои собственные настройки и параметры подключения, которые варьируются от коннектора к коннектору, но в целом коннектор требует настройки таких параметров как:
- **Учётные данные**: Логины, пароли, ключи API и другие данные для аутентификации.
- **Параметры подключения**: URL-адреса, порты, схемы базы данных.
- **Расписание обновлений**: Как часто данные должны быть извлечены из источника и загружены в целевую систему.

В Airbyte есть как собственные коннекторы, так и коннекторы, которые созданы сообщество. Помимо этого пользователи могут создавать собственные коннекторы, если стандартных решений недостаточно. В **dataCraft Core** используется много кастомных коннекторов. С их перечнем и описанием можно ознакомиться в разделе [[Connectors]]. 

В интерфейсе Airbyte, чтобы посмотреть доступные коннекторы или добавить собственный, необходимо перейти в раздел `Settings`:
![[list_of_connectors_example.jpg]]

В **dataCraft Core** добавление новых и обновление существующих коннекторов автоматизировано и осуществляется DAG’ом [[install_connectors]] на основе конфига [[Airflow Providers/Configs/connectors|connectors]].
