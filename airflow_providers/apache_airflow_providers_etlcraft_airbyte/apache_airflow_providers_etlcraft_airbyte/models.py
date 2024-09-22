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
    releaseStage: ReleaseStageEnum
    releaseDate: datetime
    sourceType: SourceTypeEnum

    # TODO: add more operators description
