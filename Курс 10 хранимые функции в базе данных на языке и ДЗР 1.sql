
/*
1. Создать функцию которает сделает бекап таблицы customers.
2. Создать функцию возвращающая средний freight с таблицы orders.
3. Создать функцию принимающую два входных параметра для генерации числа.
*/

--1 Рекомендуется использовать первый вариант создания копии таблицы
CREATE OR REPLACE FUNCTION beckup_customers1() RETURNS void AS $$

	DROP TABLE IF EXISTS beckup_customers;
	
	CREATE TABLE beckup_customers AS
	SELECT
		* 
	FROM
		customers;
	
$$ LANGUAGE SQL
;

CREATE OR REPLACE FUNCTION beckup_customers2() RETURNS void AS $$

	DROP TABLE IF EXISTS beckup_customers;
	
	SELECT
		*
	INTO
		beckup_customers
	FROM
		customers;
	
$$ LANGUAGE SQL
;

SELECT beckup_customers1();

--2
CREATE OR REPLACE FUNCTION get_avg_freight() RETURNS float8 AS $$
	SELECT
		avg(freight)
	FROM 
		orders
	;
$$ LANGUAGE SQL
;

SELECT get_avg_freight();

--3
CREATE OR REPLACE FUNCTION random_between(low int, high int) RETURNS int AS $$
BEGIN
	RETURN floor(random() * (high - low + 1) + low);
END;
$$ LANGUAGE plpgSQL;

SELECT 
	random_between(1, 3)
FROM
	generate_series(1, 10) --Используется для установки количества повторений выполнения функции 
;