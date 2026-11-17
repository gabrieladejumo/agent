%sql
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE orders_table STRING DEFAULT 'agent.dev.orders';

CREATE TABLE IF NOT EXISTS IDENTIFIER(orders_table) (
    order_id            INT,
    customer_id         INT,
    product_id          INT,
    quantity            INT,
    unit_price          DOUBLE,
    order_status        STRING,  -- 'pending', 'shipped', 'delivered', 'cancelled'
    order_date          TIMESTAMP,
    estimated_delivery  DATE
);

INSERT INTO IDENTIFIER(orders_table)
SELECT order_id, customer_id, product_id, quantity, unit_price, order_status, order_date, estimated_delivery
FROM read_files('/Volumes/agent/dev/data/orders.csv')