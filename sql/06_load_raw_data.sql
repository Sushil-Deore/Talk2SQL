USE DATABASE my_db;
USE SCHEMA raw;

PUT 'file:///Users/sushildeore/Downloads/Agents/Amazon RAG Analytics Pipeline/Amazon Sale Report.csv' @raw.%amazon_orders AUTO_COMPRESS=TRUE;

COPY INTO raw.amazon_orders
FROM @raw.%amazon_orders
FILE_FORMAT = raw.csv_fmt
ON_ERROR = 'CONTINUE';