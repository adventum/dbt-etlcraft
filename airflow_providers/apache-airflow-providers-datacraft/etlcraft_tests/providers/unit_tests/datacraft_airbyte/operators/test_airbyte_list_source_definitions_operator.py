import pytest

from airflow.decorators import dag
from airflow.models import Connection
from airflow.providers.datacraft.airbyte.operators import (
    AirbyteListSourceDefinitionsOperator,
)

from airflow.providers.datacraft.airbyte.models import SourceDefinitionSpec
from pendulum import datetime


@pytest.mark.airbyte_test
def test_get_list_source_definitions(
    airbyte_conn: Connection,
    get_workspace_id: str,
):
    @dag(
        start_date=datetime(2024, 1, 1),
        catchup=False,
    )
    def test_dag_get_list_source_definitions():
        get_result: dict[str, any] | AirbyteListSourceDefinitionsOperator = (
            AirbyteListSourceDefinitionsOperator(
                task_id="get_list_source_definitions",
                airbyte_conn_id=airbyte_conn,
                workspace_id=get_workspace_id,
            )
        )
        return get_result

    dag_object = test_dag_get_list_source_definitions()
    dag_run = dag_object.test()

    # Получаем результат дага, и проверяем через ассерты спаршенные конфиги
    task_id: str = "get_list_source_definitions"
    result: list[SourceDefinitionSpec] = dag_run.get_task_instance(task_id).xcom_pull(
        task_ids=task_id
    )

    if not result:
        raise Exception(
            "You have not any source_definitions in airbyte, but test passed"
        )

    assert result
    assert len(result) >= 1
    assert result[0].sourceDefinitionId
    assert result[0].name
