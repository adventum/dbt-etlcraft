from ..operators import AirByteGeneralOperator


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
        destination_id: str | None = None,
        destination_name: str | None = None,
        destinations_list: list | None = None,
        params: dict | None = None,
        **kwargs,
    ):
        # TODO
        super().__init__(airbyte_conn_id=airbyte_conn_id, endpoint="", **kwargs)
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
        self.destinations_list = destinations_list
        self.params = params
