%sql
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE inventory_table STRING DEFAULT 'agent.dev.inventory';

CREATE TABLE IF NOT EXISTS IDENTIFIER(inventory_table) (
    product_id      INT,
    product_name    STRING,
    sku             STRING,
    stock_quantity  INT,
    warehouse       STRING,
    restock_date    DATE
);


INSERT INTO IDENTIFIER(inventory_table)
SELECT product_id,product_name,sku,stock_quantity,warehouse,restock_date 
FROM read_files('/Volumes/agent/dev/data/inventory.csv')