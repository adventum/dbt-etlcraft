---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize
doc_status: ready
language: eng
---
# get_from_default_dict

This macro takes a path (as a list of keys) and a dictionary as input and traverses the dictionary following the path. If it reaches the end of the path successfully, it returns the value at that location in the dictionary. If it encounters a key that isn't in the dictionary before reaching the end of the path, it returns a default value.

## Arguments

- `default_dict`: The dictionary to traverse.
- `path`: A list of keys representing the path to traverse in the dictionary. The keys should be provided in the order they are to be accessed.
- `default_return`: (Optional) The value to return if the end of the path can't be reached. If not provided, an empty string is returned.

## Usage

```dbt
{% set result = get_from_default_dict(['key1', 'key2'], my_dict) %}
```

This will traverse `my_dict` by first going to `key1` and then `key2`. If `key2` exists within the dictionary located at `key1`, it returns the value there. Otherwise, it returns an empty string (or the value provided in `default_return`).

## Example

Given the following dictionary:

```dbt
{% set my_dict = {
    'fruit': {
        'color': 'red',
        'name': 'apple',
        'details': {
            'origin': 'Washington',
            'variety': 'Red Delicious'
        }
    },
    'animal': {
        'type': 'dog',
        'name': 'Rex',
        'details': {
            'breed': 'Labrador',
            'color': 'Black'
        }
    }
} %}
```

This example will return `'red'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['fruit', 'color'], my_dict) %}
```

This example will return `'Labrador'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['animal', 'details', 'breed'], my_dict) %}
```

This example will return `'Washington'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['fruit', 'details', 'origin'], my_dict) %}
```

This example will return `'dog'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['animal', 'type'], my_dict) %}
```

This example will return an empty string (since there is no `'taste'` key under `'fruit'`):

```dbt
{% set result = etlcraft.get_from_default_dict(['fruit', 'taste'], my_dict) %}
```

