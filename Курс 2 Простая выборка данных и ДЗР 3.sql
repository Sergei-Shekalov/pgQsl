/*
Задания
1. Найти заказы которые поставляются в страны с названием которое начинается с заглавной 'U'.
2. Найти заказы котрые поставляются в страны с названием которое начинается с заглавной 'N', 
   отсортировать их по весу и вывести первые 10.
3. Вывести Имя, Фамилию, номер телефона всех сотрудников у которых регион равен NULL.
4. Подсчитать количество заказчиков у которых регион не равен NULL и отсортировать по убыванию.
5. Подсчитать количество доставщиков продукции и сгруппировать их по странам и отсортировать по убыванию.
6. Подсчитать вес по заказам, сгруппировать по странам доставки, регион доставке не должен быть NULL, 
   сумма вес заказа должна быть больше 2750, отсортировать вес по убыванию.
Операции над множествами:   
7. Объеденить страны с таблиц customers and suppliers и отсортировать по возврастанию.
8. Найти страны с таблиц customers and suppliers в которых проживают работники из таблицы empioyees.
9. Вычисления стран с таблиц customers and suppliers кроме стран из таблицы empioyees.
*/

SELECT
    *
FROM
    orders
WHERE
    ship_country LIKE 'U%';
	
SELECT
    order_id,
	customer_id,
	ship_country
FROM
    orders
WHERE
    ship_country LIKE 'N%'
ORDER BY
    freight DESC
LIMIT 5;

SELECT
    Last_name,
	first_name,
	home_phone
FROM
    employees
WHERE
    region IS NULL;

SELECT
    COUNT(1)
FROM
    customers
WHERE
	region IS NOT NULL;

SELECT
    country,
	COUNT(1)
FROM
	suppliers
GROUP BY
    country
ORDER BY
    COUNT(1) DESC;
	
SELECT
    ship_country,
    SUM(freight)
FROM
    orders
WHERE
    ship_region IS NOT NULL
GROUP BY
    ship_country
HAVING
    SUM(freight) > 2750
ORDER BY
    SUM(freight) DESC;
	
SELECT
    country
FROM
    customers
	
UNION
    
SELECT
    country
FROM	
	suppliers
	
ORDER BY
    country;
	
SELECT
    country
FROM
    customers

INTERSECT

SELECT
    country
FROM
    suppliers

INTERSECT

SELECT
    country
FROM
    employees;
	
SELECT
    country
FROM
    customers

INTERSECT

SELECT
    country
FROM
    suppliers

EXCEPT

SELECT
    country
FROM
    employees;	