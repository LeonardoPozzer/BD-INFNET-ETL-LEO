WITH clientes AS (

    SELECT *
    FROM {{ ref('clientes') }}

),

pedidos AS (

    SELECT *
    FROM {{ ref('pedidos') }}

),

resumo_cliente AS (

    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_pedidos,
        MIN(order_purchase_timestamp) AS primeira_compra,
        MAX(order_purchase_timestamp) AS ultima_compra
    FROM pedidos
    GROUP BY customer_id

)

SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,

    COALESCE(r.total_pedidos, 0) AS total_pedidos,
    r.primeira_compra,
    r.ultima_compra

FROM clientes c

LEFT JOIN resumo_cliente r
        ON c.customer_id = r.customer_id