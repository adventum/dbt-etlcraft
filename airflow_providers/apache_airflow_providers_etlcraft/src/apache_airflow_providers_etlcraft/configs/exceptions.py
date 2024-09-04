
# Исключение, если искомый конфиг не был найден
class EtlcraftConfigError(Exception):
    """Кастомное исключение для ошибок конфигурации etlCraft."""
    def __init__(self, message: str):
        super().__init__(message)
        self.message = message

    def __str__(self):
        return f"EtlcraftConfigError: {self.message}"
