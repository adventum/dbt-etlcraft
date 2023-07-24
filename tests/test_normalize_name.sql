{% set inputs = ["Space Name", "Прривет, Мир!", "Start 12"] %}
{% set expected_outputs = ["Space_Name", "Prrivet_Mir", "Start_12"] %}

SELECT
{% for input, expected_output in zip(inputs, expected_outputs) -%}
    {% if not loop.first -%} UNION ALL SELECT {% endif %}
    'Test failed for input "{{ input }}". Expected output: "{{ expected_output }}", actual output: "{{ normalize_name(input) }}"' 
    WHERE '{{ normalize_name(input) }}' != '{{ expected_output }}'
{% endfor %}