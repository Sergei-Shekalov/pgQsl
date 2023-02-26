
/*
Последовательность выполнение ключевых частей запроса:
1. Блок FROM
2. Оператор ON
3. Оператор JOIN
4. Блок WHERE
5. Блок GROUP BY (Позволяет использовать псевдонимы полей)
6. Блок HAVING
7. Функции WINDOW
8. Блок SELECT
9. Оператор DICTINCT
10. Блок UNION, INTERSECT, EXCEPT
11. Блок ORDER BY (Позволяет использовать псевдонимы полей)
12. Оператор LIMIT, TOP
*/

/*
Соединения
FROM - используются с данным ключевым словом.
Виды соеденния
INNER JOIN - Внутреннее соединенние, фильтрация данных выполняется по указанным ключевым полям.
             Данные по ключу есть в левой и правой таблице.

<table name left>
INNER JOIN <table name right> ON <table name left>.<column name> = <table name right>.<column name>;
<table name left>
JOIN <table name right> ON <table name left>.<column name> = <table name right>.<column name>;			 
JOIN <table name right> USING (<column name>); 

NATURAL JOIN - Внутреннее соединенние, фильтрация данных выполняется по одинаковым наименованиям полей в таблицах.
               Данные по одинаковым наименованиям полей есть в левой и правой таблице.
			   Ни когда нельзя использовать.

LEFT JOIN - Внешние левое соединение, фильтрация данных выполняется по указанным ключевым полям.
            Данные по ключу есть в левой таблице, в правой таблице данных может не быть.
			В таком случа отсуствующие значения в правой таблице заменяються на NULL.
			Если в правой таблице есть несколько значений по ключу тогда вернется результат,
			значения левой таблицы переумножаться на значения правой таблицы.
			
<table name left>
LEFT JOIN <table name right> ON <table name left>.<column name> = <table name right>.<column name>;			

<table name left>
LEFT JOIN <table name right> USING(<column name>);

RIGHT JOIN - Внешние правое соединение, фильтрация данных выполняется по указанным ключевым полям.
             Данные по ключу есть в правой таблице, в левой таблице данных может не быть. 
             В таком случа отсуствующие значения в левой таблице заменяються на NULL.
			 Если в левой таблице есть несколько значений по ключу тогда вернется результат,
			 значения правой таблицы переумножаться на значения левой таблицы.
             По умолчанию используют Левое внешние соединение.

<table name right>
RIGHT JOIN <table name left> ON <table name right>.<column name> = <table name left>.<column name>;

<table name right>
RIGHT JOIN <table name left> USING(<column name>);

FULL JOIN - Внешние полное соединение, фильтрация данных выполняется по указанным ключевым полям.
            Если по ключу не удалось соединиться то возвращает значение правой или левой таблице NULL.

<table name left>
FULL JOIN <table name right> ON <table name left>.<column name> = <table name right>.<column name>;

<table name left>
FULL JOIN <table name right> USING(<column name>);

CROSS JOIN - Внешние соединение таблиц, данные между которыми переумножаются друг на друга.

<table name left>
CROSS JOIN <table name right>;

<table name left>,
<table name right>;

SELF JOIN - Соединение одной и тойже таблице между собой используя разные наименования таблиц.
            Соединение таблицы саму на себя.

<table name> AS table name left
LEFT JOIN <table name> AS <table name right> ON <table name left>.<column name> = <table name right>.<column name>;

Способы указания поля и условия соединения:

1. ON - Используеться для указания связей полей с разными наименованиями, а также для указания любого условия соединения.
        Проверяет, совпадают ли записи в таблицах назначения и источника, до объединения таблиц.
2. USING - Используется для указания связей полей с одинаковыми наименованиями, используеться условие соединение '='.

Псевдонимы таблиц

	AS - Назначает псевданим таблицы
	<column name> AS <new table name>
	• - Через пробел можно назначить псевданим таблицы
	<column name>•<new table name>
*/


-- ПРИМЕРЫ INNER JOIN
SELECT
    COUNT (*) AS products_count
FROM
    products;
	
SELECT 
    product_name,
	suppliers.company_name,
	units_in_stock
FROM 
    products
    INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY
     units_in_stock DESC;
	 
SELECT
    category_name,
	SUM(units_in_stock)
FROM
    products
	INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY
    category_name
ORDER BY
    SUM(units_in_stock) DESC
LIMIT 5;

SELECT
    category_name,
	SUM(unit_price * units_in_stock)
FROM
    products
	INNER JOIN categories ON products.category_id = categories.category_id
WHERE
    discontinued <> 1
GROUP BY
    category_name
HAVING
    SUM(unit_price * units_in_stock) > 5000
ORDER BY
    SUM(unit_price * units_in_stock) DESC;
	
SELECT
    order_id,
	customer_id,
	first_name,
	last_name
FROM orders
INNER JOIN employees 
ON orders.employee_id = employees.employee_id;

	
SELECT
    orders.order_date, 
	product_name,
	ship_country,
   	products.unit_price,
	quantity,
	discount
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN products
ON order_details.product_id = products.product_id;

SELECT
    contact_name,
	company_name,
	phone,
	first_name,
	last_name,
	title,
	order_date,
	product_name,
	ship_country,
	products.unit_price,
	quantity,
	discount
FROM 
    orders
    JOIN order_details
    ON orders.order_id = order_details.order_id
    JOIN products
    ON order_details.product_id = products.product_id
    JOIN customers
    ON orders.customer_id = customers.customer_id
    JOIN employees
    ON orders.employee_id = employees.employee_id
WHERE
    ship_country = 'USA'
;

-- ПРИМЕРЫ NATURAL JOIN

SELECT
    order_id,
	customer_id,
	first_name,
	last_name,
	title
FROM orders
     NATURAL JOIN employees
	 
-- ПРИМЕРЫ LEFT JOIN
SELECT
    company_name,
	product_name
FROM
    suppliers
    LEFT JOIN products
	ON suppliers.supplier_id = products.supplier_id
;

SELECT
    company_name,
	order_id
FROM
    customers
    LEFT JOIN orders
	ON customers.customer_id = orders.customer_id
WHERE
    order_id IS NULL
;


SELECT
    last_name,
	order_id
FROM 
    employees
    LEFT JOIN orders
    ON orders.employee_id = employees.employee_id 
WHERE
    order_id IS NULL;
	
SELECT
    COUNT(*)
FROM 
    employees
    LEFT JOIN orders
    ON orders.employee_id = employees.employee_id 
WHERE
    order_id IS NULL;
	
-- ПРИМЕРЫ RIGHT JOIN	

SELECT
    company_name,
	order_id
FROM
    orders
    RIGHT JOIN customers 
	ON customers.customer_id = orders.customer_id
WHERE
    order_id IS NULL
;

SELECT
    last_name,
	order_id
FROM 
    orders
    RIGHT JOIN employees 
    ON employees.employee_id = orders.employee_id 
WHERE
    order_id IS NULL;

-- ПРИМЕРЫ FULL JOIN

SELECT
    company_name,
	order_id
FROM
    orders
    FULL JOIN customers
    ON orders.customer_id = customers.customer_id
	
-- ПРИМЕРЫ CROSS JOIN

SELECT
    company_name,
	order_id
FROM
    orders,
    customers 

-- ПРИМЕРЫ SELF JOIN 
	
CREATE TABLE emploee(
      emploee_id INT PRIMARY KEY,
      first_name VARCHAR(255) NOT NULL,
      last_name VARCHAR(255) NOT NULL,
	  manager_id INT,
	  FOREIGN KEY (manager_id) REFERENCES emploee(emploee_id)
);

INSERT INTO emploee(
      emploee_id,
	  first_name,
	  last_name,
	  manager_id
)
VALUES
     (1, 'Windy', 'Hays', NULL),
	 (2, 'Ava', 'Christensen', 1),
	 (3, 'Hassan', 'Conner', 1),
	 (4, 'Anna', 'Reeves', 2),
	 (5, 'Sau', 'Norman', 2),
	 (6, 'Kelsie', 'Hays', 3),
	 (7, 'Tory', 'Goff', 3),
	 (8, 'Salley', 'Laster', 3)
;	 

SELECT
    e.first_name || ' ' || e.last_name AS employee, 
	m.first_name || ' ' || m.last_name AS manager
FROM
    emploee e
LEFT JOIN emploee m
ON e.emploee_id = m.emploee_id
ORDER BY 
    manager DESC
;

--ПРИМЕРЫ ИСПОЛЬЗОВАНИЯ СПОСОБА СОЕДИНЕНИЯ USING

SELECT
    contact_name,
	company_name,
	phone,
	first_name,
	last_name,
	title,
	order_date,
	product_name,
	ship_country,
	products.unit_price,
	quantity,
	discount
FROM 
    orders
    JOIN order_details
    USING (order_id)
    JOIN products
    USING (product_id)
    JOIN customers
    USING (customer_id)
    JOIN employees
    USING (employee_id)
WHERE
    ship_country = 'USA'
;
 
