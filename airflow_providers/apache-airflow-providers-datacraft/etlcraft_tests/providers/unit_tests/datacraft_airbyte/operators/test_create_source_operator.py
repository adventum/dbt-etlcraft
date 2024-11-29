import pytest

from airflow.decorators import dag
from airflow.models import Connection
from airflow.providers.datacraft.airbyte.operators.airbyte_create_source_definitions_operator import (
    AirbyteCreateSourceDefinitionsOperator,
)
from airflow.providers.datacraft.airbyte.operators.airbyte_create_source_operator import (
    AirbyteCreateSourceOperator,
)
from airflow.providers.datacraft.airbyte.models import SourceSpec, SourceDefinitionSpec
from pendulum import datetime


@pytest.mark.airbyte_test
def test_create_source(
    airbyte_conn: Connection,
    get_workspace_id: str,
):
    """
    В тесте сначала создаем source_definition, а потом создаем source.
    """

    create_source_definition_configuration = {
        "name": "Test Google Sheets Connector v2",
        "dockerRepository": "adventum/source-google-sheets",
        "dockerImageTag": "1.0.1",
        "documentationUrl": "",
    }
    task_id_create: str = "create_source_definition"

    @dag(
        start_date=datetime(2024, 1, 1),
        catchup=False,
    )
    def test_dag_create_source_definition():
        create_definition_result: (
            dict[str, any] | AirbyteCreateSourceDefinitionsOperator
        ) = AirbyteCreateSourceDefinitionsOperator(
            task_id=task_id_create,
            airbyte_conn_id=airbyte_conn,
            workspace_id=get_workspace_id,
            source_definition_configuration=create_source_definition_configuration,
        )
        return create_definition_result

    dag_object_create = test_dag_create_source_definition()
    dag_run_create = dag_object_create.test()
    create_result: SourceDefinitionSpec = dag_run_create.get_task_instance(
        task_id_create
    ).xcom_pull(task_ids=task_id_create)

    assert create_result.sourceDefinitionId

    connection_configuration = {
        "credentials": {"auth_type": "Service", "service_account_info": ""},
        "spreadsheets": [
            {
                "spreadsheet_id": "https://docs.google.com/spreadsheets/d/1XimqM1pRoVN9Iqu86h69ewk6GDwKn5fO2YwKFKhNeBU",
                "field_name_map_stream": [],
            }
        ],
        "field_name_map": [],
    }
    task_id_update: str = "create_source"

    @dag(
        start_date=datetime(2024, 1, 1),
        catchup=False,
    )
    def test_dag_create_source():
        create_source_result: dict[str, any] | AirbyteCreateSourceOperator = (
            AirbyteCreateSourceOperator(
                task_id=task_id_update,
                airbyte_conn_id=airbyte_conn,
                workspace_id=get_workspace_id,
                source_definition_id=create_result.sourceDefinitionId,
                name=create_result.name,
                connection_configuration=connection_configuration,
            )
        )
        return create_source_result

    dag_object_update = test_dag_create_source()
    dag_run_update = dag_object_update.test()

    # Получаем результат дага, и проверяем через ассерты спаршенные конфиги
    create_source_result: SourceSpec = dag_run_update.get_task_instance(
        task_id_update
    ).xcom_pull(task_ids=task_id_update)

    assert create_source_result
    assert create_source_result.sourceId
    assert create_source_result.name == create_source_definition_configuration["name"]
