SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    {{ limpar_texto('customer_city') }} AS customer_city,
    UPPER(TRIM(COALESCE(customer_state, 'NA'))) AS customer_state

FROM {{ source('consumo', 'stg_clientes') }}