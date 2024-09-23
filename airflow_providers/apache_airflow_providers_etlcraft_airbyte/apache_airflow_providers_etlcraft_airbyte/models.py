from datetime import datetime

from pydantic import BaseModel

from .operators.enums import (
    SupportLevelEnum,
    ReleaseStageEnum,
    SourceTypeEnum,
)


class SourceDefinitionSpec(BaseModel):
    sourceDefinitionId: str
    name: str
    dockerRepository: str
    dockerImageTag: str
    documentationUrl: str | None = None
    icon: str | None = None
    protocolVersion: str | None = None
    custom: bool | None = None
    supportLevel: SupportLevelEnum | None = None
    releaseStage: ReleaseStageEnum | None = None
    releaseDate: datetime | None = None
    sourceType: SourceTypeEnum | None = None
    resourceRequirements: dict | None = None
    maxSecondsBetweenMessages: int | None = None
    lastPublished: datetime | None = None
    cdkVersion: str | None = None
    metrics: dict | None = None
    language: str | None = None
