{% macro limpar_texto(coluna) %}

    LOWER(
        TRIM(
            REPLACE(
                COALESCE({{ coluna }}, 'nao_informado'),
                '_',
                ' '
            )
        )
    )

{% endmacro %}