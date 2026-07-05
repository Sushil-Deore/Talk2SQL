SELECT
    idx,
    order_id,
    order_date,
    UPPER(TRIM(status)) AS status,
    fulfilment,
    sales_channel,
    ship_service_level,
    style,
    sku,
    category,
    size,
    asin,
    courier_status,
    qty,
    currency,
    COALESCE(amount, 0) AS amount,
    UPPER(TRIM(ship_city)) AS ship_city,
    UPPER(TRIM(ship_state)) AS ship_state,
    ship_postal_code,
    ship_country,
    promotion_ids,
    b2b,
    fulfilled_by
FROM {{ source('raw', 'amazon_orders') }}
WHERE order_id IS NOT NULL
  AND qty > 0
QUALIFY ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_date DESC) = 1