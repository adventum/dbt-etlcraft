# normalize_name

This macro takes a `name` as an argument and returns a version of it that can be used as a column name. The normalization process includes the following steps:

1. Replace spaces with underscores.
2. Transliterate any Cyrillic letters to their Latin equivalents.
3. Remove non-alphanumeric symbols.


## Usage

```sql
{{ etlcraft.normalize_name(name) }}
```
## Arguments
+ `name` (string): The name to be normalized.

## Example
```sql
-- Normalize a column name
{{ etlcraft.normalize_name('My Column Name') }}
```
## Output
```sql
My_Column_Name
```

**Перевод**
 
# normalize_name

Этот макрос принимает имя в качестве аргумента и возвращает его версию, которая может быть использована в качестве имени столбца. Процесс нормализации включает следующие шаги:
1. Замена пробелов подчеркиваниями.
2. Транслитерация любых кириллических букв на их латинские эквиваленты.
3. Удаление не буквенно-цифровых символов.

## Использование
```sql
{{ etlcraft.normalize_name(name) }}
```

## Аргументы

+ `name` (строка): Имя, которое нужно нормализовать.

## Пример
```sql
-- Нормализация имени столбца
{{ etlcraft.normalize_name('Название Моего Столбца') }}
```

## Вывод
```sql
Nazvanie_Moego_Stolbca 
```