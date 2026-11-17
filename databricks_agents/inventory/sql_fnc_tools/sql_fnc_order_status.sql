%sql
-- ==================================================
-- TOOL : Look up Order status by Order ID
-- ==================================================
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE order_status STRING DEFAULT 'agent.dev.get_order_status';

CREATE OR REPLACE FUNCTION IDENTIFIER(order_status)(
    input_order_id INT COMMENT 'The Order ID to look up status for'
)
RETURNS STRING
COMMENT 'Returns the current status, estimated delivery date, and total value of a given order ID.'
RETURN
    SELECT CONCAT(
           'Order ID: ',        order_id, ', ',
           'Status: ',          order_status, ', ',
           'Order Date: ',      CAST(order_date AS DATE), ', ',
           'Est. Delivery: ',   estimated_delivery, ', ',
           'Total Value: $',    ROUND(quantity * unit_price,2)
    )
    FROM IDENTIFIER('orders')
    WHERE order_id = input_order_id
    LIMIT 1;
