%sql
-- ==================================================
-- TOOL : Calculate refund eligibility for an Order
-- ==================================================
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE refund_eligibility STRING DEFAULT 'agent.dev.get_check_refund_eligibility';

CREATE OR REPLACE FUNCTION IDENTIFIER(refund_eligibility)(
    input_order_id INT COMMENT 'The Order ID to evaluate for refund eligibility'
)
RETURNS STRING
COMMENT 'Evaluates whether an order is eligible for a refund based on its status and delivery date. Returns eligibility status and reason'
RETURN
    SELECT CASE
        WHEN order_status = 'cancelled' THEN 
            CONCAT('Order ', input_order_id, ' is ELIGIBLE for full refund. Reason: Order was cancelled')

        WHEN order_status = 'delivered' AND DATEDIFF(CURRENT_DATE(), estimated_delivery) <=30 THEN 
            CONCAT('Order ', input_order_id, ' is ELIGIBLE for full refund. Reason: Order was delivered within 30-day return window (',      DATEDIFF(CURRENT_DATE(), estimated_delivery), ' days ago).')

       WHEN order_status = 'delivered' AND DATEDIFF(CURRENT_DATE(), estimated_delivery) >30 THEN 
            CONCAT('Order ', input_order_id, ' is NOT ELIGIBLE for full refund. Reason: Return window expired (',      
               DATEDIFF(CURRENT_DATE(), estimated_delivery), ' day since delivery; limit is 30days).')

       WHEN order_status IN ('pending','shipped') THEN 
            CONCAT('Order ', input_order_id, ' is ELIGIBLE for cancellation and full refund. Reason: Order has not yet been delivered (status: ', order_status,').')
        ELSE 
            CONCAT('Order ', input_order_id, ' Unable to . Reason: Unable to determine refund eligibility  ', order_status, ').')
        END
    FROM IDENTIFIER('orders')
    WHERE order_id = input_order_id
    LIMIT 1;
