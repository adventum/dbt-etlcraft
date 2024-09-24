from pydantic import BaseModel

from .enums import (
    NamespaceDefinitionEnum,
    TimeUnitEnum,
    ConnectionStatusEnum,
    NonBreakingChangesPreferenceEnum,
)


class Model(BaseModel, extra="ignore"):
    """BaseModel that ignores extra fields"""

    ...


class SourceDefinitionSpec(BaseModel):
    sourceDefinitionId: str
    name: str
    dockerRepository: str
    dockerImageTag: str
    documentationUrl: str | None = None


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
