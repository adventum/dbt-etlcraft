from enum import StrEnum


class SupportLevelEnum(StrEnum):
    community = "community"
    certified = "certified"
    archived = "archived"


class ReleaseStageEnum(StrEnum):
    alpha = "alpha"
    beta = "beta"
    generally_available = "generally_available"
    custom = "custom"


class SourceTypeEnum(StrEnum):
    api = "api"
    file = "file"
    database = "database"
    custom = "custom"
