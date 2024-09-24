from enum import StrEnum


class NamespaceDefinitionEnum(StrEnum):
    source = "source"
    destination = "destination"
    customformat = "customformat"


class TimeUnitEnum(StrEnum):
    minutes = "minutes"
    hours = "hours"
    days = "days"
    weeks = "weeks"
    months = "months"


class ConnectionStatusEnum(StrEnum):
    active = "active"
    inactive = "inactive"
    deprecated = "deprecated"


class NonBreakingChangesPreferenceEnum(StrEnum):
    ignore = "ignore"
    disable = "disable"
    propagate_columns = "propagate_columns"
    propagate_fully = "propagate_fully"
