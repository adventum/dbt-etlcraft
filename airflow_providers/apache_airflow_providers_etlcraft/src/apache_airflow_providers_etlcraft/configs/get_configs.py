import json
import yaml
import re

from airflow.models import Variable
from airflow.utils.db import create_session

from .exceptions import EtlcraftConfigError


default_value_mapping = {
    "connectors": {
        "type": "templated_file",
        "format": "yaml",
    },
    "presets": {
        "type": "templated_file",
        "format": "json",
    },
    "datasources": {
        "type": "datacraft_variable",
        "format": "json",
    },
    "metadata": {
        "type": "templated_file",
        "format": "yaml",
    },
    "events": {
        "type": "templated_file",
        "format": "yaml",
    },
    "attributions": {
        "type": "datacraft_variable",
        "format": "json",
    },
    "base": {
        "type": "templated_file",
        "format": "yaml",
    }
}


# Функция, которая парсит метаконфиги и возвращает их значение
# (Например из: source_for_config_etlcraft_from_datacraft)
def etlcraft_variable(variable_id_without_prefix: str, namespace: str, default_value=None) -> str:
    variable_id = f"{namespace}_{variable_id_without_prefix}"
    return Variable.get(variable_id, default_var=default_value)


def processing_single(
    config_name: str,
    namespace: str,
    source_key: str,
    format_key: str,
    path_key: str,
    entire_datacraft_variable: bool = False
):

    # Сначала определяем source, format и path для конфигурации
    source = Variable.get(
        source_key,
        default_var=default_value_mapping.get(config_name).get("type")
        if config_name in default_value_mapping.keys() else {}
    )
    file_format = Variable.get(
        format_key,
        default_var=default_value_mapping.get(config_name).get("format")
        if config_name in default_value_mapping.keys() else {}
    )
    path = Variable.get(path_key, default_var="")

    # В зависимости от источника, загружаем конфигурацию
    if source in ["file", "templated_file"]:
        if source == "templated_file":
            path = f"templated_configs/{config_name}"

        if source == "file" and not path:
            path = f"configs/{config_name}"

        if not path.endswith(('.json', '.yml', '.yaml')):
            extension = ".json" if file_format == "json" else ".yml"
            path += extension

        try:
            with open(path, 'r') as file:
                if file_format == "json":
                    config = json.load(file)
                else:
                    config = yaml.safe_load(file)
        except FileNotFoundError:
            raise EtlcraftConfigError(f"File '{path}' not found.")

    elif source == "datacraft_variable":
        json_datacraft_variable = Variable.get(f"from_datacraft{path}")
        if isinstance(json_datacraft_variable, str):
            json_datacraft_variable = json.loads(json_datacraft_variable)
        if entire_datacraft_variable:
            config = json_datacraft_variable
        else:
            config = json_datacraft_variable.get(config_name, {})
            if config == {}:
                raise EtlcraftConfigError(
                    f"Config {config_name} not found in datacraft_variable, "
                    f"check the contents of the variable "
                    f"or check datacraft_variable name in Airflow"
                )

    elif source == "other_variable":
        other_variable_path = f"{path}"
        default_other_variable_path = f"{config_name}"
        config = Variable.get(other_variable_path, default_var=default_other_variable_path)
        if file_format == "json":
            config = json.loads(config)
        else:
            config = yaml.safe_load(config)
    else:
        raise EtlcraftConfigError(f"Unknown source type: {source}")

    return config


def get_configs(
    config_names: list[str] = None,
    namespace: str = "etlcraft",
    entire_datacraft_variable: bool = False
) -> dict[str, dict]:

    if config_names is None:
        config_names = ["base",]

    all_configs = {}

    def get_single(config_name: str) -> dict:

        source_key = f"source_for_config_{namespace}_{config_name}"
        format_key = f"format_for_config_{namespace}_{config_name}"
        path_key = f"path_for_config_{namespace}_{config_name}"

        if config_name == "base":
            #suffix = Variable.get(f"path_for_config_{namespace}_{config_name}")

            with create_session() as session:

                part_of_variables_need_to_find = f"{namespace}_base_"
                # Полный список переменных
                airflow_vars = {
                    var.key: var.val for var in session.query(Variable)
                }
                # Отфильтрованный список переменных под конкретный base
                filtered_vars = [
                    key for key, value in airflow_vars.items()
                    if part_of_variables_need_to_find in key
                ]

                pattern = rf"source_for_config_{namespace}_base_(.+)$"
                suffixes = set()
                for variable_name in filtered_vars:
                    match = re.search(pattern, variable_name)
                    if match:
                        suffixes.add(match.group(1))

                # Обработка для каждого подконфига base,
                # по итогу получается 1 конфиг base, состоящий их подконфигов
                all_base_config = {}
                for suffix in suffixes:

                    source_key = f"source_for_config_{namespace}_{config_name}_{suffix}"
                    format_key = f"format_for_config_{namespace}_{config_name}_{suffix}"
                    path_key = f"path_for_config_{namespace}_{config_name}_{suffix}"

                    all_base_config[suffix] = processing_single(
                        suffix, namespace, source_key, format_key,
                        path_key, entire_datacraft_variable
                    )

                # Добавление получившегося base в переменную {namespace}_base
                Variable.update(f"{namespace}_base", all_base_config)

                return all_base_config
        else:
            config = processing_single(
                config_name, namespace, source_key, format_key,
                path_key, entire_datacraft_variable
            )

            return config

    for config_name in config_names:
        all_configs[config_name] = get_single(config_name)

    return all_configs
