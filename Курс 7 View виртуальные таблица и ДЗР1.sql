
/*
1.Создание представления которое обьеденяет orders,customers и employees.
2.Создание представления в котором будут представлены активные товары.
*/

--1.
CREATE VIEW orders_customers_employees AS
SELECT
    orders.order_date,
	orders.required_date,
	orders.shipped_date,
	orders.ship_postal_code,
	customers.company_name,
	customers.contact_name,
	customers.phone,
	employees.last_name,
	employees.first_name,
	employees.title
FROM	  
    orders AS orders 
	INNER JOIN customers AS customers
	ON orders.customer_id = customers.customer_id
	INNER JOIN employees AS employees
	ON orders.employee_id = employees.employee_id
;

ALTER VIEW orders_customers_employees RENAME TO oce_old

;

CREATE OR REPLACE VIEW orders_customers_employees AS
SELECT
    orders.order_date,
	orders.required_date,
	orders.shipped_date,
	orders.ship_postal_code,
	customers.company_name,
	customers.contact_name,
	customers.phone,
	customers.postal_code,
	employees.last_name,
	employees.first_name,
	employees.title
FROM	  
    orders AS orders 
	INNER JOIN customers AS customers
	ON orders.customer_id = customers.customer_id
	INNER JOIN employees AS employees
	ON orders.employee_id = employees.employee_id
;

DROP VIEW IF EXISTS oce_old
;

SELECT
    *
FROM
	orders_customers_employees
WHERE
    order_date > '1997-01-01'
;

--2.
CREATE VIEW active_products AS
SELECT
	*
FROM
	products AS products
WHERE
    products.discontinued <> 1
WITH LOCAL CHECK OPTION
;

SELECT
	*
FROM
    products
;

INSERT INTO active_products
VALUES(78, 'Original Frankfurter test', 15, 20, 'abs', 1, 1, 1, 1, 1)
;

