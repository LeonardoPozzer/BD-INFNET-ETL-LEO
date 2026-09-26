WITH clientes AS (

    SELECT *
    FROM {{ ref('clientes') }}

),

pedidos AS (

    SELECT *
    FROM {{ ref('pedidos') }}

),

itens AS (

    SELECT *
    FROM {{ ref('itens_pedido') }}

),

data_referencia AS (

    SELECT
        DATE(MAX(order_purchase_timestamp)) AS data_maxima
    FROM pedidos

),

rfm_cliente AS (

    SELECT
        p.customer_id,

        COUNT(DISTINCT p.order_id) AS frequencia,

        DATE_DIFF(
            d.data_maxima,
            DATE(MAX(p.order_purchase_timestamp)),
            DAY
        ) AS recencia_dias,

        ROUND(
            SUM(i.price + i.freight_value),
            2
        ) AS valor_total_gasto,

        MIN(p.order_purchase_timestamp) AS primeira_compra,
        MAX(p.order_purchase_timestamp) AS ultima_compra

    FROM pedidos p

    INNER JOIN itens i
        ON p.order_id = i.order_id

    CROSS JOIN data_referencia d

    GROUP BY
        p.customer_id,
        d.data_maxima

)

SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,

    COALESCE(r.frequencia, 0) AS frequencia,
    r.recencia_dias,
    COALESCE(r.valor_total_gasto, 0) AS valor_total_gasto,
    r.primeira_compra,
    r.ultima_compra,

    CASE
        WHEN r.frequencia >= 5
             AND r.recencia_dias <= 90
            THEN 'Cliente VIP'

        WHEN r.frequencia >= 3
             AND r.recencia_dias <= 180
            THEN 'Cliente Frequente'

        WHEN r.recencia_dias > 365
            THEN 'Cliente Inativo'

        WHEN r.frequencia IS NULL
            THEN 'Sem Compras'

        ELSE 'Cliente Regular'
    END AS categoria_cliente

FROM clientes c

LEFT JOIN rfm_cliente r
    ON c.customer_id = r.customer_id