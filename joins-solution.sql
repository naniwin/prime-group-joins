--Get all customers and their addresses.
SELECT * FROM customers JOIN addresses ON customers.id = addresses.customer_id;
--Get all orders and their line items (orders, quantity and product).
SELECT * FROM orders JOIN line_items ON line_items.order_id = orders.id JOIN products ON line_items.product_id = products.id;
--Which warehouses have cheetos?
SELECT * FROM warehouse JOIN warehouse_product ON warehouse_product.warehouse_id = warehouse.id JOIN products ON products.id = warehouse_product.product_id WHERE products.description = 'cheetos';
---- delta

--Which warehouses have diet pepsi?
SELECT * FROM warehouse JOIN warehouse_product ON warehouse_product.warehouse_id = warehouse.id JOIN products ON products.id = warehouse_product.product_id WHERE products.description = 'diet pepsi';
---- alpha, delta, gamma

--Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

--How many customers do we have?
--How many products do we carry?
--What is the total available on-hand quantity of diet pepsi?