import json
import yaml
from airflow.models import Variable
from typing import Optional, Sequence
from airflow.utils.context import Context
from airflow.models.baseoperator import BaseOperator

from .exceptions import EtlcraftConfigError


# Функция, которая парсит метаконфиги и возвращает их значение
# (Например из: source_for_config_etlcraft_from_datacraft)
def etlcraft_variable(variable_id_without_prefix: str, namespace: str, default_value=None) -> str:
    variable_id = f"{namespace}_{variable_id_without_prefix}"
    return Variable.get(variable_id, default_var=default_value)


def get_configs(
    config_names: list[str],
    namespace: str = "etlcraft",
    entire_datacraft_variable: bool = True
) -> dict[str, dict]:
    all_configs = {}

    def load_config(config_name: str) -> dict:
        source_key = f"source_for_config_{namespace}_{config_name}"
        format_key = f"format_for_config_{namespace}_{config_name}"
        path_key = f"path_for_config_{namespace}_{config_name}"

        # Сначала определяем source, format и path для конфигурации
        source = Variable.get(source_key, default_var={})
        file_format = Variable.get(format_key, default_var={})
        path = Variable.get(path_key, default_var={})

        # В зависимости от источника, загружаем конфигурацию
        if source in ["file", "templated_file"]:
            if source == "templated_file":
                path = f"config_templates/{config_name}"

            if source == "file" and (path is None or path == {}):
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
            json_datacraft_variable = etlcraft_variable(config_name, namespace)
            if isinstance(json_datacraft_variable, str):
                json_datacraft_variable = json.loads(json_datacraft_variable)
            if entire_datacraft_variable:
                config = json_datacraft_variable
            else:
                config = json_datacraft_variable.get(path, {})

        elif source == "other_variable":
            other_variable_path = f"{namespace}_{path}"
            default_other_variable_path = f"{namespace}_{config_name}"
            config = Variable.get(other_variable_path, default_var=default_other_variable_path)
            if file_format == "json":
                config = json.loads(config)
            else:
                config = yaml.safe_load(config)
        else:
            raise EtlcraftConfigError(f"Unknown source type: {source}")

        return config

    for config_name in config_names:
        all_configs[config_name] = load_config(config_name)

    return all_configs

# # Оператор собирающий все конфиги
# class CollectConfigsOperator(BaseOperator):
#     template_fields: Sequence[str] = ("config_names", "namespace")
#
#     def __init__(
#         self,
#         *,
#         config_names: Optional[list[str]] = None,
#         namespace: Optional[str] = "etlcraft",
#         entire_datacraft_variable: Optional[bool] = True,
#         **kwargs,
#     ) -> None:
#         super().__init__(**kwargs)
#         self.config_names = config_names if config_names else []
#         self.namespace = namespace
#         self.entire_datacraft_variable = entire_datacraft_variable
#
#     def load_config(self, config_name: str) -> dict:
#         source_key = f"source_for_config_{self.namespace}_{config_name}"
#         format_key = f"format_for_config_{self.namespace}_{config_name}"
#         path_key = f"path_for_config_{self.namespace}_{config_name}"
#
#         # Сначала определяем source, format и path для конфигурации
#         source = Variable.get(source_key, default_var={})
#         file_format = Variable.get(format_key, default_var={})
#         path = Variable.get(path_key, default_var={})
#
#         # В зависимости от источника, загружаем конфигурацию
#         if source in ["file", "templated_file"]:
#             if source == "templated_file":
#                 path = f"config_templates/{config_name}"
#
#             if source == "file" and (path is None or path == {}):
#                 path = f"configs/{config_name}"
#
#             if not path.endswith(('.json', '.yml', '.yaml')):
#                 extension = ".json" if file_format == "json" else ".yml"
#                 path += extension
#
#             try:
#                 with open(path, 'r') as file:
#                     if file_format == "json":
#                         config = json.load(file)
#                     else:
#                         config = yaml.safe_load(file)
#             except FileNotFoundError:
#                 raise EtlcraftConfigError(f"File '{path}' not found.")
#
#         elif source == "datacraft_variable":
#             json_datacraft_variable = etlcraft_variable(config_name, self.namespace)
#             if type(json_datacraft_variable) is str:
#                 json_datacraft_variable = json.loads(json_datacraft_variable)
#             if self.entire_datacraft_variable:
#                 config = json_datacraft_variable
#             else:
#                 config = json_datacraft_variable.get(path, {})
#
#         elif source == "other_variable":
#             other_variable_path = f"{self.namespace}_{path}"
#             default_other_variable_path = f"{self.namespace}_{config_name}"
#             config = Variable.get(other_variable_path, default_var=default_other_variable_path)
#             if file_format == "json":
#                 config = json.loads(config)
#             else:
#                 config = yaml.safe_load(config)
#         else:
#             raise EtlcraftConfigError(f"Unknown source type: {source}")
#
#         return config
#
#     def execute(self, context: "Context") -> dict:
#         all_configs = {}
#         for config_name in self.config_names:
#             all_configs[config_name] = self.load_config(config_name)
#         return all_configs
#
#
# # Функция обертка над оператором CollectConfigsOperator, для упрощенного получения конфигов
# def get_config(
#         config_names: Optional[list[str]] = None,
#         namespace: Optional[str] = "etlcraft",
#         entire_datacraft_variable: Optional[bool] = True,
# ) -> dict:
#
#     operator = CollectConfigsOperator(
#         task_id="collect_configs",
#         config_names=config_names,
#         namespace=namespace,
#         entire_datacraft_variable=entire_datacraft_variable
#     )
#
#     context = {}
#
#     configs = operator.execute(context)
#     return configs
