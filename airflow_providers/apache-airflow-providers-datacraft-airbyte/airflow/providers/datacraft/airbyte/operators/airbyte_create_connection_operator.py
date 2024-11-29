from ..operators import AirByteGeneralOperator

from airflow.utils.context import Context
from ..models import (
    ConnectionSpec,
)


class AirbyteCreateConnectionOperator(AirByteGeneralOperator):
    """
    Create connection operator
    :param airbyte_conn_id: Airflow connection object for AirByte
    :param name: Required. Name of new connection
    :param source_id: Source id to create connection
    :param source_name: Source name to create connection
    :param destination_id: Destination id to create connection
    :param destination_name: Destination name to create connection
    :param destinations_list: TODO
    :param params: connection configuration
    """

    def __init__(
        self,
        name: str,
        airbyte_conn_id: str | None = None,
        source_id: str | None = None,
        source_name: str | None = None,
        sources_list: list | None = None,
        destination_id: str | None = None,
        destination_name: str | None = None,
        destinations_list: list | None = None,
        params: dict | None = None,
        **kwargs,
    ):
        # TODO
        # super().__init__(airbyte_conn_id=airbyte_conn_id, endpoint="", **kwargs)
        self.name = name

        self.source_id = source_id
        self.source_name = source_name
        if not self.source_id and not self.source_name:
            raise ValueError(
                "To create connection you must specify source_id or source_name"
            )

        self.destination_id = destination_id
        self.destination_name = destination_name
        if not self.destination_id and not self.destination_name:
            raise ValueError(
                "To create connection you must specify destination_id or destination_name"
            )

        # TODO
        self.sources_list = sources_list
        self.destinations_list = destinations_list
        self.params = params
        self.kwargs = kwargs

    def execute(self, context: Context) -> ConnectionSpec | None:
        if self.sources_list:
            pass
            # result: list = []
            # for source, idx in enumerate(self.sources_list):
            #
            #     super().__init__(
            #         airbyte_conn_id=self.airbyte_conn_id,
            #         endpoint="destinations/update",
            #         request_params={
            #             "destinationId": destination_id,
            #             "connectionConfiguration": connection_configuration,
            #             "name": self.name,
            #         },
            #         use_legacy=True,
            #         **kwargs,
            #     )
            #
            #     resp: dict[str, any] = super().execute(context)
            #     res: SourceSpec = SourceSpec.model_validate(resp)
            #     result.append(res)
            # return result
        else:
            super().__init__(
                airbyte_conn_id=self.airbyte_conn_id,
                endpoint="connections/create",
                request_params={
                    "name": self.name,
                    "sourceId": self.source_id,
                    "destinationId": self.destination_id,
                    **self.params,
                },
                use_legacy=True,
                **self.kwargs,
            )
            resp: dict[str, any] = super().execute(context)
            res: ConnectionSpec = ConnectionSpec.model_validate(resp)

            return res
