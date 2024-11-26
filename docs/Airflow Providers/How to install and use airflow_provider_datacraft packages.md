### **Как установить и использовать пакеты airflow_provider_datacraft**

Кастомный провайдер airflow состоит из четырёх пакетов:
-  apache-airflow-providers-datacraft
-  apache-airflow-providers-datacraft-airbyte
-  apache-airflow-providers-datacraft-dags
-  apache-airflow-providers-datacraft-defaults

Все они находятся в папке `dbt-etlcraft/airflow_providers` Первый из них - главный

Предварительно рекомендуется установить пакетный менеджер - pip install hatch и обновить версию pip - `python -m pip install --upgrade pip`


**Способы установки:**
1. Быстрая установка, если не обязательно чтобы пакеты были в editable(development) режиме, то находясь в папке `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft` нужно выполнить команду `pip install .[with-datacraft-subpackages]` - это установит все 4 пакета

2. Установка каждого пакета в editable(development) режиме (позволяет менять код пакетов и видеть изменения сразу, не собирая и устанавливая их по-новой)
   Для этого нужно выполнить команду `pip install -e .` , находясь в каждой из директорий пакетов, приведенных ниже:
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft`
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft-airbyte`
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft-dags`
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft-defaults`

Если нужно собрать библиотеку(Например чтобы интегрировать пакеты с проектом airflow), нужно в каждой из папок выше запустить команду `hatch build` и в папке `dist` появится файл в формате `.whl`

Модули библиотеки, после установки, вызываются через from airflow.providers.datacraft.xxx

**Запуск тестов:**
Сами тесты находятся в директории `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft/etlcraft_tests/providers`

Для их запуска выполняется команда `hatch env run pytest etlcraft_tests` в директории `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft`

В `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft/etlcraft_tests/providers/unit_tests/fixtures/airflow_variables.py` есть функция, с помощью которой можно получить словарь с переменными airflow для тестирования

Если при запуске тестов в первый раз появляется ошибка, `TypeError: int() argument must be a string, a bytes-like object or a real number, not 'NoneType'`  То запускаем тесты еще раз, эта ошибка из-за отсутствия записей при прогоне тестов впервые.
При последующих запусках этой ошибки не будет

В `etlcraft_tests/providers/conftest.py` находится код инициализирующий базу данных для тестов, также в этом файле прописываются фикстуры, если нужно их использовать напрямую в тестах, без импорта
________________________________________________________________________

UPD : Я еще раз протестил установку в development режиме, и все-таки я пока не нашел способа, чтобы библиотека работала в editable режиме, как я понял, из-за большой вложенности структуры установленных библиотек airflow и специфичности установки кастомного провайдера в editable-mode (Устанавливаются не файлы пакета, а лишь ссылка на директорию в формате .pth)

Поэтому есть другой способ обновлять пакеты после изменения в них: 
1. (Например) Есть уже установленные 4 пакета: datacraft, datacraft-airbyte, datacraft-dags, datacraft-defaults
2. Внесли какие-то изменения в исходные пакеты
3. Устанавливаем снова библиотеку с внесенными изменениями - 
   `pip install --no-cache-dir .[with-datacraft-subpackages]` в директории `airflow_providers/apache-airflow-providers-datacraft`

Удалить все библиотеки можно с помощью комманды:   `pip uninstall apache-airflow-providers-datacraft apache-airflow-providers-datacraft-airbyte apache-airflow-providers-datacraft-dags apache-airflow-providers-datacraft-defaults`