
/*
Логические операторы и функции:

CASE - Логический оперетор, возвращающий true/false.
	CASE WHEN <if> THEN <result>
		 WHEN <if> THEN <result>
		 ELSE <result>

COALESCE - Логическая функция котороя проверяет значение на NULL, позволяет указывать N число значений.
           Если значение NULL, то проверяет следующие значение NULL и возвращает его.
		   Если все значения NULL то возвращает NULL.
		   Используеться для замены значений NULL.
NULLIF - Логическая функция для сверки двух значений, если они равны возвращает NULL иначе возвращает первое значение.
         Используеться совместно с функцией COALESCE.
*/

-- CASE
SELECT
	products.product_name,
	products.unit_price,
	products.units_in_stock,
	CASE WHEN products.units_in_stock >= 100 THEN
	     'lots of'
		 WHEN products.units_in_stock >= 50 
		     AND products.units_in_stock < 100 THEN
		 'average'
		 ELSE 'low number'
	END AS amount	
FROM
	products AS products
ORDER BY
	products.units_in_stock DESC false
;

SELECT
	orders.order_id,
	orders.order_date,
	CASE WHEN date_part('month', orders.order_date) BETWEEN 3 AND 5 THEN
	     'spring'
		 WHEN date_part('month', orders.order_date) BETWEEN 6 AND 8 THEN
		 'summer'
		 WHEN date_part('month', orders.order_date) BETWEEN 9 AND 11 THEN
		 'autumn'
		 ELSE
		 'winter'
	END	AS season 
FROM
	orders AS orders
;

SELECT
	product_name,
	unit_price,
	CASE WHEN unit_price >= 30 THEN
		 'Expensive'	
	     WHEN unit_price < 30 THEN
		 'Inexpensive'
		 ELSE
		 'Undetermined'
	END AS price_desciption
FROM
	products
ORDER BY
    unit_price DESC
;	

--COALESCE
SELECT
      COALESCE(NULL, NULL,3,4) AS test
;

SELECT
	*
FROM
	orders
LIMIT 10
;

SELECT
	order_id,
	order_date,
	COALESCE(ship_region, 'unknown') AS ship_region 
FROM
	orders
LIMIT 10
;

SELECT
	last_name,
	first_name,
	COALESCE(region, 'unknown') AS region
FROM
	employees
;

--COALESCE&NULLIF

SELECT
	NULLIF(1, 1) AS test,
	NULLIF(1, 2) AS test1,
	COALESCE(NULLIF(1, 2), 2) AS test_not_null
;

SELECT
	contact_name,
	COALESCE(NULLIF(city, ''), 'unknown') AS city
FROM
	customers
;

CREATE TABLE budgets
(
	dept          serial,
	current_year  decimal,
	previous_year decimal
);

INSERT INTO budgets(current_year, previous_year)
VALUES
	(1000, 1500),
	(NULL, 3000),
	(0,    1000),
	(NULL, 1500),
	(3000, 2500),
	(1700, 1700),
	(1500, NULL)
;

SELECT
	*
FROM
	budgets
;

SELECT
	dept,
	COALESCE(TO_CHAR(NULLIF(current_year, previous_year), 'FM99999999'), 'Sam as last year') AS budget
FROM
	budgets
;

	