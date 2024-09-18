import yaml
import json
from collections import namedtuple
from apache_airflow_providers_etlcraft_dags.exceptions import EtlcraftConfigError
from apache_airflow_providers_etlcraft_defaults import get_etlcraft_defaults
from airflow.models import Variable
import pathlib
from enum import Enum

Metaconfig = namedtuple("Metaconfig", "source format path")
Source = Enum('Source', 'datacraft_variable templated_file file other_variable')
Format = Enum('Format', 'json yaml')

def get_configs(namespace: str, config_names=[]) -> dict:    
    default_metaconfigs = get_single_config('metaconfigs', get_metaconfig(namespace, 'metaconfigs'))
    base = get_single_config('base', get_metaconfig(namespace, 'base', default_metaconfigs))    
    for base_var in base.keys():
        overriden_val = process_single_config(namespace, f"base_{base_var}", default_metaconfigs, base)
        if overriden_val:
            base[base_var] = overriden_val    
    if 'base' in config_names:
        config_names.remove('base')
    if 'metaconfigs' in config_names:
        config_names.remove('metaconfigs')
    all_configs = {'base': base}
    for config_name in config_names:
        all_configs[config_name] = process_single_config(namespace, config_name, default_metaconfigs, base)    

def process_single_config(namespace: str, config_name: str, default_metaconfigs: Metaconfig, base_config: dict):
    return get_single_config(config_name, get_metaconfig(namespace, config_name, default_metaconfigs), base_config)

def get_default_path(source):
    match source:
        case Source.datacraft_variable | Source.templated_file:
            return ''
        case Source.file:
            return f"configs/{source}"
        case Source.other_variable:
            return source
    raise EtlcraftConfigError(f"unknown source: {source}")

def get_metaconfig(namespace: str, config_name: str, defaults: None) -> Metaconfig:
    if not defaults:
        if config_name != 'metaconfigs':
            raise EtlcraftConfigError("get_metaconfig is called without defaults. It is possible only for metaconfigs itself") 
        else:
            defaults = {"mataconfigs": {"source": "templated_file", "format": "json"}}
            Metaconfig._fields
    source, format, path = (Variable.get(f"{x}_for_{namespace}_{config_name}", default_var=defaults.get(config_name, {}).get(x)) for x in Metaconfig._fields)    
    if source is None or format is None:
        if config_name.startswith('base_'):
            return None
        raise EtlcraftConfigError(f'source or format not found for config {config_name} (namespace {namespace})')
    source = Source[source]
    format = Format[format]
    if path is None:
        path = get_default_path(source)
    return Metaconfig(source, format, path)

def parse_by_format(text, format):
    match format:
        case Format.yaml:
            return yaml.safe_load(text)
        case Format.json:
            return json.loads(text)
    raise EtlcraftConfigError(f"unknown format ({format})")
    
def get_single_config(config_name: str, metaconfig: Metaconfig, base_config=None):
    if not base_config:
        if config_name not in ('metaconfigs', 'base'):
            raise EtlcraftConfigError("get_single_config is called without base_config. It is possible only for metaconfigs or base")
        else:
            base_config = {}
    match metaconfig.source:
        case Source.file:
            filepath = pathlib.Path(metaconfig.path)
            if not (filepath.exists() and filepath.is_file()):                
                raise EtlcraftConfigError(f"file not found ({str(filepath)})")
            content = filepath.read_text()
            return parse_by_format(content, metaconfig.format)
        case Source.templated_file:
            filepath = pathlib.Path(metaconfig.path)
            if not (filepath.exists() and filepath.is_file()):                
                content = get_etlcraft_defaults(config_name, metaconfig.format, metaconfig.path, base_config)
            else:
                content = filepath.read_text()
            return parse_by_format(content, metaconfig.format)
        case Source.other_variable:
            return parse_by_format(Variable.get(metaconfig.path), metaconfig.format)
        case Source.datacraft_variable:
            datacraft_variable = f"from_datacraft{metaconfig.path}"
            var = parse_by_format(Variable.get(datacraft_variable), metaconfig.format)
            ret = var.get(config_name)
            if ret is None:
                raise EtlcraftConfigError(f"key {config_name} not found in dataCraft variable {datacraft_variable}")
            return ret

            
        