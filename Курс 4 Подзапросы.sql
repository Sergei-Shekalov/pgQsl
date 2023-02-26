
/*
Подзапросы - Результат выборки который используеться в основной выборке, в скобках () .
             
Подзапросы всегда указываються в скобках.
(SELECT <column name> FROM <table name>) 

!Зачастую подзапросы можно переписать на JOIN, но бывают и сключения.
JOIN отрабытывает в основном всегда быстрее, 
но бывают случае когда запрос с подзапрос работает быстрее, зависит от плана запроса.!

Места использования подзапросов:

1. Блок FROM
   1. FROM()
   2. Оператор JOIN()
2. Блок WHERE
   Используется совместно с логическими операторами:
   1. IN () - 
   2. Операторы сравнения
   3. NOT Используется совместно
      1. IN()
	  2. Операторы сравнения
	  3. EXISTS()
	  4. ANY()
	  5. ALL()	  
   4. EXISTS () - Возращающий true если есть хоть одна запись в наборе или таблице иначе false.
   5. ANY () - Возращающий true если есть хоть одна запись в наборе удовлеворяющие условию иначе false.
   6. ALL () - Возращающий true если все записи в наборе удовлеворяющие условию, иначе false. Если набор пустой по умочанию вернет true.
3. Оператор LIMIT()
*/

--Примеры использования подзапроса в блоке WHERE

--IN
SELECT DISTINCT
    company_name
FROM
    suppliers
WHERE
    country IN (SELECT country
			    FROM customers)
;

--Результат JOIN эквавалентен результату IN   
SELECT DISTINCT
    suppliers.company_name
FROM
    suppliers
    JOIN customers USING(country)
;

--Оператор сравнения
SELECT DISTINCT
    product_name,
	units_in_stock
FROM
    products
WHERE
    units_in_stock > (SELECT
					      AVG(units_in_stock)
					  FROM
					      products
					 )
ORDER BY
    units_in_stock
;

--EXISTS

SELECT DISTINCT
    company_name,
	contact_name
FROM
    customers
WHERE
    EXISTS (SELECT
			    customer_id
		    FROM
			    orders
		    WHERE
		       customer_id = customers.customer_id --Отработает как внутренние соединение
			   AND freight BETWEEN 50 AND 100
		   )   
;

SELECT DISTINCT
    company_name,
	contact_name
FROM
    customers
WHERE
    EXISTS (SELECT 
			    order_date,
			    customer_id
		    FROM
			    orders
		    WHERE
			    customer_id = customers.customer_id --Отработает как внутренние соединение
		        AND order_date BETWEEN '1995-02-01' AND '1996-07-15'
		   )
;

--NOT EXISTS
SELECT DISTINCT
    company_name,
	contact_name
FROM
    customers
WHERE
    NOT EXISTS (SELECT 
			    order_date,
			    customer_id
		    FROM
			    orders
		    WHERE
			    customer_id = customers.customer_id --Отработает как внутренние соединение
		        AND order_date BETWEEN '1995-02-01' AND '1996-07-15'
		   )
;

SELECT DISTINCT
    product_name
FROM
    products
WHERE
    NOT EXISTS (SELECT 
			        orders.order_id 
		        FROM
			        orders
				    JOIN order_details USING(order_id)
		        WHERE
			        order_details.product_id = products.product_id --Отработает как внутренние соединение
		            AND order_date BETWEEN '1995-02-01' AND '1996-07-15'
			   )
;

--ANY

SELECT DISTINCT
    company_name
FROM customers
WHERE
    customer_id = ANY(SELECT
					      customer_id
					  FROM
					      orders
					  JOIN order_details USING(order_id)
					  WHERE 
					       quantity > 40
					 )
;

--Результат IN эквавалентен результату ANY
SELECT DISTINCT
    company_name
FROM customers
WHERE
    customer_id IN (SELECT
					      customer_id
					  FROM
					      orders
					  JOIN order_details USING(order_id)
					  WHERE 
					       quantity > 40
					 )
;	

--Результат JOIN эквавалентен результату ANY
SELECT DISTINCT
    company_name
FROM
    customers
    JOIN orders USING(customer_id)
	JOIN order_details USING(order_id)
WHERE 
    quantity > 40
;	
					 
--ALL

SELECT DISTINCT
    product_name,
	quantity
FROM
    products
	JOIN order_details USING(product_id)
WHERE
    quantity > ALL(SELECT 
				       AVG(quantity)
				   FROM
				       order_details
				   GROUP BY
				       product_id
				   )
;

SELECT DISTINCT
    product_name,
	quantity
FROM
    products
	JOIN order_details USING(product_id)
WHERE
    quantity > ALL(SELECT 
				       AVG(quantity)
				   FROM
				       order_details
				   WHERE
				       false
				   GROUP BY
				       product_id
				   ) --Подзапрос вернет Истину
;

SELECT DISTINCT
    product_name,
	quantity
FROM
    products
	JOIN order_details USING(product_id)
WHERE
    quantity < ALL(SELECT 
				       AVG(quantity)
				   FROM
				       order_details
				   GROUP BY
				       product_id
				   )
;
	
--Пример использования подзапроса в операторе LIMIT
SELECT
    category_name,
	SUM(units_in_stock)
FROM
    products
    JOIN categories USING(category_id)
GROUP BY 
    category_name
ORDER BY
    SUM(units_in_stock) DESC
LIMIT (SELECT
	      MIN(product_id) +4 
	  FROM
	      products)	
;

