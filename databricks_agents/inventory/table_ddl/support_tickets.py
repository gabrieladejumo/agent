%sql
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE support_tickets_table STRING DEFAULT 'agent.dev.support_tickets';

CREATE TABLE IF NOT EXISTS IDENTIFIER(support_tickets_table) (
    ticket_id    INT,
    customer_id  INT,
    order_id     INT,
    issue_type   STRING,  -- 'refund', 'shipping', 'product', 'other'
    description  STRING,
    status       STRING,  -- 'open', 'in_progress', 'resolved'
    created_at   TIMESTAMP,
    resolved_at  TIMESTAMP
);


INSERT INTO IDENTIFIER(support_tickets_table)
SELECT ticket_id, customer_id, order_id, issue_type, description,status,created_at,resolved_at
FROM read_files('/Volumes/agent/dev/data/support_tickets.csv')