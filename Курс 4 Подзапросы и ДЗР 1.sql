
/*
ДЗ
1. Вывести продукты количество которых в прадаже меньше среднего количество продуктов в детальных заказов.
2. Вывести общую сумму freight заказа, для компаний заказчика стоимость которых равна или болше велечины freight
   а также дата отгрузки должна быть '1996-06-16' - '1996-07-31'
3. Вывести три заказа с наибольшей стоимостью, которые были созданы после '1997-09-01'
   и доставлены в южные страны USA('Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador',
                                   'Guyana', 'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela')
   где стоимость заказа расчитывается с учетом скидки,
   также выведены следующие поля (customer_id, ship_country, order_price) и отсортированы по стоимости заказа по убыванию.
4. Вывести все товары которых было заказано 10 единиц.   
*/

--1
SELECT
    AVG(quantity)
FROM
    order_details
GROUP BY
    product_id
	
SELECT
    product_name,
	units_in_stock
FROM
    products
WHERE
    units_in_stock < ALL(SELECT
                             AVG(quantity)
                         FROM
                             order_details
						 GROUP BY
							 product_id
						)
ORDER BY
    units_in_stock DESC
;

--2
SELECT
    customer_id,
	SUM(freight) AS freight_sum
FROM
    orders 
	JOIN(SELECT
     		 customer_id,
    		 AVG(freight) AS freight_avg 
		 FROM
    		 orders
		 GROUP BY
             customer_id) AS orders_avg 
	USING(customer_id)
 
WHERE
    freight > orders_avg.freight_avg
    AND shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
GROUP BY
   customer_id
ORDER BY
   freight_sum DESC
;

--3
SELECT
    customer_id,
	ship_country,
	order_price
FROM orders
     JOIN (SELECT
    			order_id,
				SUM(unit_price * quantity - unit_price * quantity * discount) AS order_price
		   FROM
    			order_details
		   GROUP BY 
    			order_id) AS od
	 USING(order_id)
WHERE
     ship_country IN ('Argentina',
					  'Bolivia',
					  'Brazil',
					  'Chile',
					  'Colombia',
					  'Ecuador',
					  'Guyana',
					  'Paraguay',
					  'Peru',
					  'Suriname',
					  'Uruguay',
					  'Venezuela'
	 				 )
	AND order_date >= '1997-09-01'
ORDER BY
    order_price DESC
LIMIT 3
;

--4
SELECT
    product_name
FROM
    products
WHERE
    product_id = ANY(SELECT
    					 product_id
					 FROM
    					 order_details
 					 WHERE
    					 quantity = 10)
;

SELECT DISTINCT
    product_name
FROM
    products
    JOIN order_details
	USING (product_id)
WHERE
    quantity = 10
;