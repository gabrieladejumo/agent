%sql
-- ==================================================
-- TOOL : Check product inventory level
-- ==================================================
USE CATALOG agent;
USE SCHEMA dev;
DECLARE OR REPLACE check_product_inventory STRING DEFAULT 'agent.dev.check_inventory';

CREATE OR REPLACE FUNCTION IDENTIFIER(check_product_inventory)(
    input_product_name STRING COMMENT 'The name of the product to check the inventory for'
)
RETURNS STRING
COMMENT 'Returns current stock level, warehouse location, and restock date for a given product name.'
RETURN
    SELECT CONCAT(
           'Product: ',        product_name, ', ',
           'SKU: ',            sku, ', ',
           'In Stock: ',      stock_quantity, ' units, ',
           'Warehouse: ',     warehouse, ', ',
           'Next Restock',    restock_date
    )
    FROM IDENTIFIER('inventory')
    WHERE LOWER(product_name)  LIKE LOWER(CONCAT('%',input_product_name, '%'))
    LIMIT 1;
