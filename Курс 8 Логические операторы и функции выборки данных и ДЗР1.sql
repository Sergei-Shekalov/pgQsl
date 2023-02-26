/*
1. Вывести имя контакта заказчика его город и страну отсортировать по возврастанию имени контакта заказчика и городу, 
   если город равен NULL тогда отсортировать по имени контакта заказчика и стране.
2. Вывести наименование продукта, цену продукта, сформировать столбец price по условию.
   цена >= 100 тогда значение too expesnsive иначе если цена >= 50 и < 100 тогда значение average иначе low price.
3. Найти имя заказчика не сделавщего не одного заказа, и вывести имя заказчика и id заказа, 
   если id заказа = NULL тогда заменить на значение no orders.
*/

--1
INSERT INTO customers(customer_id, contact_name, city, country, company_name)
VALUES
	('AAAAA', 'Alfred Mann', NULL, 'USA', 'fake_company'),
	('BBBBB', 'Alfred Mann', NULL, 'Austria', 'fake_company')
;

SELECT
	contact_name,
	city,
	country
FROM
	customers
ORDER BY
	contact_name,
	(
		CASE WHEN city IS NULL THEN
			country
		ELSE
			city
		END
	)
;	

--2
SELECT
	product_name,
	unit_price,
    CASE WHEN unit_price >= 100 THEN
		 'too expesnsive'
		 WHEN unit_price >= 50 AND unit_price < 100 THEN
		 'average'
		 ELSE
		 'low price'
	END	AS price 
FROM
	products
ORDER BY 	
	unit_price DESC
;

--3
SELECT DISTINCT
	contact_name,
	COALESCE(order_id :: text, 'no orders') AS order_id_text
FROM customers AS customers
LEFT JOIN orders AS orders USING(customer_id)
WHERE
	orders.order_id IS NULL