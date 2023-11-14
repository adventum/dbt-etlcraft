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

**Перевод**
 
# Макрос get_from_default_dict

Этот макрос принимает путь (в виде списка ключей) и словарь в качестве входных данных, а затем проходит по словарю, следуя указанному пути. Если он успешно достигает конца пути, он возвращает значение в указанном месте в словаре. Если встречается ключ, которого нет в словаре до достижения конца пути, возвращается значение по умолчанию.

## Аргументы

- default_dict: Словарь для обхода.
- path: Список ключей, представляющих путь для обхода в словаре. Ключи должны быть предоставлены в том порядке, в котором к ним будет осуществляться доступ.
- default_return: (Необязательно) Значение, которое вернется, если конец пути не может быть достигнут. Если не предоставлено, возвращается пустая строка.

## Использование

{% set result = get_from_default_dict(['ключ1', 'ключ2'], my_dict) %}
Это приведет к обходу my_dict, сначала переходя к ключу1, а затем к ключу2. Если ключ2 существует в словаре, расположенном по ключу1, возвращается значение. В противном случае возвращается пустая строка (или значение, указанное в default_return).

## Пример

Учитывая следующий словарь:

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

В этом примере будет возвращено  `'red'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['fruit', 'color'], my_dict) %}
```

В этом примере будет возвращено  `'Labrador'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['animal', 'details', 'breed'], my_dict) %}
```

В этом примере будет возвращено  `'Washington'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['fruit', 'details', 'origin'], my_dict) %}
```

В этом примере будет возвращено  `'dog'`:

```dbt
{% set result = etlcraft.get_from_default_dict(['animal', 'type'], my_dict) %}
```

В этом примере будет возвращена пустая строка (since there is no `'taste'` key under `'fruit'`):

```dbt
{% set result = etlcraft.get_from_default_dict(['fruit', 'taste'], my_dict) %}
```