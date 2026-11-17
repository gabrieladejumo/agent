%sql
-- ==================================================
-- TOOL : Get all Orders for a given Customer ID
-- ==================================================
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE customer_orders STRING DEFAULT 'agent.dev.get_customer_orders';

CREATE OR REPLACE FUNCTION IDENTIFIER(customer_orders)(
    input_customer_id INT COMMENT 'The Customer ID whose orders should be retrieved'
)
RETURNS TABLE (
            order_id INT,
            order_status STRING,
            order_date DATE,
            total_value DOUBLE
    )
    COMMENT 'Returns all orders placed by a given customer ID, including status and total order value.'
    RETURN
    SELECT 
    order_id,
    order_status,
    CAST(order_date AS DATE) AS order_date,
    round(unit_price * quantity) AS total_value
    FROM IDENTIFIER('orders')
    WHERE customer_id = input_customer_id
    ORDER BY order_date DESC;
    
