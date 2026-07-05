SELECT
    order_id,
    order_date,
    status,
    category,
    sku,
    qty,
    amount,
    ship_city,
    ship_state,
    ship_country
FROM {{ ref('stg_amazon_orders') }}