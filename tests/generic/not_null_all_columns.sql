{% test not_null_all_columns(model) %}
    {% set columns = adapter.get_columns_in_relation(model) %}
    {% for column in columns %}

        SELECT
            '{{ column.name }}' AS coluna,
            COUNT(*) AS quantidade_nulos

        FROM {{ model }}
        WHERE {{ adapter.quote(column.name) }} IS NULL
        HAVING COUNT(*) > 0

        {% if not loop.last %}
            UNION ALL
        {% endif %}
    {% endfor %}
{% endtest %}