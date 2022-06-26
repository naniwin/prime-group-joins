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
SELECT customers.id as "customers id", customers.first_name, customers.last_name, COUNT(orders.id) as "count of orders" FROM customers JOIN addresses ON customers.id = addresses.customer_id JOIN orders ON orders.address_id = addresses.id GROUP BY customers.id;
-- to shorten --
SELECT c.id as "customers id", c.first_name, c.last_name, COUNT(o.id) as "count of orders" FROM customers c JOIN addresses a ON c.id = a.customer_id JOIN orders o ON o.address_id = a.id GROUP BY c.id;

--How many customers do we have?
SELECT COUNT(id) FROM customers;

--How many products do we carry?
SELECT COUNT(id) FROM products;

--What is the total available on-hand quantity of diet pepsi?
SELECT SUM(on_hand) FROM warehouse_product JOIN products ON products.id = warehouse_product.product_id WHERE products.description = 'diet pepsi';

--- Stretch Goals ---
--How much was the total cost for each order?
SELECT orders.id as "orders id", SUM(unit_price) FROM orders JOIN line_items ON line_items.order_id = orders.id JOIN products ON products.id = line_items.product_id GROUP BY orders.id;

--How much has each customer spent in total?
SELECT customers.first_name, SUM(products.unit_price) FROM customers JOIN addresses ON addresses.customer_id = customers.id JOIN orders ON orders.address_id = addresses.id JOIN line_items ON line_items.order_id = orders.id JOIN products ON products.id = line_items.product_id GROUP BY customers.first_name;

--How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT customers.first_name, COALESCE ( SUM(products.unit_price), 0) as "total" FROM customers 
LEFT JOIN addresses ON addresses.customer_id = customers.id 
LEFT JOIN orders ON orders.address_id = addresses.id 
LEFT JOIN line_items ON line_items.order_id = orders.id 
LEFT JOIN products ON products.id = line_items.product_id 
GROUP BY customers.first_name;