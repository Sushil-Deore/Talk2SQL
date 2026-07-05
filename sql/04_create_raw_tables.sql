USE WAREHOUSE COMPUTE_WH;
USE DATABASE my_db;
USE SCHEMA raw;

CREATE TABLE IF NOT EXISTS raw.amazon_orders (
    idx INT,
    order_id STRING,
    order_date DATE,
    status STRING,
    fulfilment STRING,
    sales_channel STRING,
    ship_service_level STRING,
    style STRING,
    sku STRING,
    category STRING,
    size STRING,
    asin STRING,
    courier_status STRING,
    qty INT,
    currency STRING,
    amount FLOAT,
    ship_city STRING,
    ship_state STRING,
    ship_postal_code STRING,
    ship_country STRING,
    promotion_ids STRING,
    b2b BOOLEAN,
    fulfilled_by STRING
);