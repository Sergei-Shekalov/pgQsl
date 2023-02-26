
/*
ДЗР
1. Найти заказчиков и обслуживающий их заказы сотрудников, 
   заказчики и сотрудники должны быть из города 'London',
   доставка должна усуществлятся компанией 'Speedy Express',
   вывести компанию заказчика и имя сотрудника.
2. Найти активные продукты из категории ('Beverages', 'Seafood'),
   которые в прода менее 20 едениц,
   вывести наименование продуктов, количество единиц продажи и контакты поставщика.
3. Найти заказчиков не сделавших не одного заказа вывести имя заказчика и order_id.   
*/

-- 1
SELECT *
FROM shippers
;

SELECT
    customers.company_name,
	CONCAT(first_name, '', last_name)
FROM 
     orders
     JOIN customers
     USING (customer_id)
     JOIN employees
	 USING (employee_id)
     JOIN shippers
	 ON orders.ship_via = shippers.shipper_id
WHERE
     customers.city = 'London'
	 AND employees.city = 'London'
	 AND shippers.company_name = 'Speedy Express'
;	 

--2
SELECT
    product_name,
	units_in_stock,
	contact_name,
	phone
FROM
    products
	JOIN categories USING(category_id)
    JOIN suppliers USING(supplier_id)
WHERE
    category_name IN('Beverages', 'Seafood')
	AND discontinued = 0
	AND units_in_stock < 20
ORDER BY
    units_in_stock
;

--3
SELECT
    contact_name,
	order_id
FROM
    customers
    LEFT JOIN orders USING (customer_id)
WHERE
   order_id IS NULL
ORDER BY
   contact_name
;

SELECT
    contact_name,
	order_id
FROM
    orders
    RIGHT JOIN customers USING (customer_id)
WHERE
   order_id IS NULL
ORDER BY
   contact_name
;   
   