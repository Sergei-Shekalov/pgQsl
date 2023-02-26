
/*
ДЗР 1
1. Полная выборка из таблицы customers.
2. Выбрать столбцы (contact_name, city) из таблицы customers
3. Выбрать заказы с количеством затраченных дней на разгрузку
4. Выбрать уникальные значения city из таблицы customers
5. Выбрать уникальные сочитания city, country из таблицы customers
6. Подсчитать количество записей в таблице customers
7. Подсчитать количество значений country из таблицы customers
*/

SELECT
    *
FROM 
    customers;

SELECT
    contact_name,
	city
FROM
    customers;
	
SELECT
    order_id,
	shipped_date - order_date  
FROM
    orders;
	
SELECT DISTINCT
    city
FROM
    customers;

SELECT DISTINCT
    city,
	country
FROM
    customers;
	
SELECT
    COUNT(customer_id)
FROM
    customers;

SELECT
    COUNT(DISTINCT country)
FROM
    customers;