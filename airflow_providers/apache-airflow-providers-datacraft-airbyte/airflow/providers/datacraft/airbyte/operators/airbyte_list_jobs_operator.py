from ..enums import JobStatusEnum
from ..models import ConnectionSpec, AirByteJobSpec
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
        statuses: list[JobStatusEnum] | None = None,
        **kwargs,
    ):
        # TODO: description is not clear
        self._statuses: list[JobStatusEnum] = (
            statuses if statuses else [JobStatusEnum.pending, JobStatusEnum.running]
        )
        self._connection_id: str | None = get_connection(
            connection_id, connection_name, connections, allow_none=True
        )
        super().__init__(
            airbyte_conn_id=airbyte_conn_id,
            endpoint="jobs/list",
            request_params={"configTypes": self._statuses},
            use_legacy=True,
            **kwargs,
        )

    def execute(self, context: Context) -> list[AirByteJobSpec] | None:
        resp: dict[str, any] = super().execute(context)
        res: list[AirByteJobSpec] = []
        for job in resp["jobs"]:
            job_spec = AirByteJobSpec(
                jobId=job["job"]["id"],
                status=job["job"]["status"],
                jobType=job["job"]["configType"],
                connectionId=job["job"]["connectionId"],
            )
            if self._connection_id and job_spec.connectionId != self._connection_id:
                continue
            res.append(job_spec)
        return res
