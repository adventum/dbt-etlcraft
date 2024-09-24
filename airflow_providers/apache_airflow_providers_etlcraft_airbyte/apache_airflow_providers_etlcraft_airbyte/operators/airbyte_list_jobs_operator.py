from ..models import SourceDefinitionSpec, ConnectionSpec
from .airbyte_general_operator import (
    AirByteGeneralOperator,
)
from airflow.utils.context import Context

from ..utils import get_connection


class AirbyteListJobsOperator(AirByteGeneralOperator):
    """
    List AirByte source definitions
    :param airbyte_conn_id: Required. Airbyte connection id
    :param connection_id: Id of AirByte connection
    :param connection_name: Name of AirByte connection
    :param connections: List of AirByte connections
    :param statuses: List of job statuses. Takes all by default
    """

    def __init__(
        self,
        airbyte_conn_id: str,
        connection_id: str | None = None,
        connection_name: str | None = None,
        connections: list[ConnectionSpec] | None = None,
        statuses: list[str] | None = None,
        **kwargs,
    ):
        # TODO: description is not clear
        self._statuses = (
            statuses
            if statuses
            else [
                "check_connection_source",
                "check_connection_destination",
                "discover_schema",
                "get_spec",
                "sync",
                "reset",
            ]
        )
        self._connection_id = get_connection(
            connection_id, connection_name, connections
        )
        super().__init__(
            airbyte_conn_id=airbyte_conn_id,
            endpoint="jobs/list",
            request_params={"configTypes": self._statuses},
            use_legacy=True,
            **kwargs,
        )

    def execute(self, context: Context) -> list[SourceDefinitionSpec] | None:
        resp: dict[str, any] = super().execute(context)
        res: list[SourceDefinitionSpec] = [
            SourceDefinitionSpec.model_validate(spec)
            for spec in resp["sourceDefinitions"]
        ]
        return res
