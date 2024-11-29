from pydantic import BaseModel

from .enums import (
    NamespaceDefinitionEnum,
    TimeUnitEnum,
    ConnectionStatusEnum,
    NonBreakingChangesPreferenceEnum,
    JobStatusEnum,
    JobSyncConfigTypeEnum,
)


class Model(BaseModel, extra="ignore"):
    """BaseModel that ignores extra fields"""

    ...


class BaseSourceDefinition(BaseModel):
    name: str
    dockerRepository: str
    dockerImageTag: str
    documentationUrl: str | None = None


class SourceDefinitionSpec(BaseSourceDefinition):
    sourceDefinitionId: str


class WorkspaceSpec(Model):
    workspaceId: str
    name: str
    slug: str


class ScheduleSpec(Model):
    units: int
    timeUnit: TimeUnitEnum


class ConnectionSpec(Model):
    connectionId: str
    name: str
    sourceId: str
    destinationId: str
    status: ConnectionStatusEnum
    schedule: ScheduleSpec | None = None
    nonBreakingChangesPreference: NonBreakingChangesPreferenceEnum | None = None
    namespaceDefinition: NamespaceDefinitionEnum | None = None
    namespaceFormat: str | None = None
    prefix: str | None = None


class BaseDestinationDefinition(Model):
    name: str
    dockerRepository: str
    dockerImageTag: str
    documentationUrl: str | None = None


class DestinationDefinitionSpec(BaseDestinationDefinition):
    destinationDefinitionId: str
    # name: str
    # dockerRepository: str
    # dockerImageTag: str
    # documentationUrl: str | None = None


class DestinationSpec(Model):
    destinationId: str
    name: str


class AirByteJobSpec(Model):
    jobId: str
    status: JobStatusEnum
    jobType: str
    connectionId: str


class SourceSpec(Model):
    sourceId: str
    name: str
    connectionConfiguration: dict


class AirbyteAttemptSpec(Model):
    attempt: dict[any, any]


class JobSyncSpec(Model):
    id: str | int
    configType: JobSyncConfigTypeEnum
    configId: str | int
    createdAt: str | int
    updatedAt: str | int
    startedAt: str | int
    status: JobStatusEnum
    attempts: [AirbyteAttemptSpec]
