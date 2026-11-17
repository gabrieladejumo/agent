%sql
-- ==================================================
-- TOOL : Look Up existing support tickets by Customer ID
-- ==================================================
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE support_tickets STRING DEFAULT 'agent.dev.get_support_tickets';

CREATE OR REPLACE FUNCTION IDENTIFIER(customer_orders)(
    input_customer_id INT COMMENT 'The Customer ID to retrieve support tickets for'
)
RETURNS TABLE (
            ticket_id INT,
            order_id INT,
            issue_type STRING ,
            status STRING,
            description STRING,
            created_at TIMESTAMP
    )
COMMENT 'Returns all open and in-progress support tickets for a given customer ID'
RETURN
    SELECT 
        ticket_id ,
        order_id ,
        issue_type ,
        status ,
        description ,
        created_at 
    FROM IDENTIFIER('support_tickets')
    WHERE customer_id = input_customer_id
    AND status != 'resolved'
    ORDER BY created_at DESC;
    
