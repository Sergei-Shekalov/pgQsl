/*
1. Найти все заказы из стран "'France', 'Austria', 'Spain'".
2. Найти все заказы и отсортировать их по полю required_date по убыванию и полю shipped_date по возрастанию.
3. Найти минимальную цену для всех продуктов которых в продаже боллее 30 штук.
4. Найти максимальное количество продукта которого больше всего в продаже с ценой больше 30.
5. Найти среднее количество дней которое потрачено на отргрузку на заказы из USA.
6. Найти сумму цен на продукты с учетом их количества к продаже и discontinued <> 1.  
*/

SELECT *
FROM
    orders
WHERE
    ship_country IN ('France', 'Austria', 'Spain');
	
SELECT *
FROM
    orders
ORDER BY
    required_date DESC, -- Поле когда долны были отгрузить заказ 
	shipped_date; -- Поле фактической отгрузки заказа
	
SELECT 
    MIN(unit_price)
FROM
    products
WHERE
    units_in_stock > 30; 

SELECT
   MAX(units_in_stock)
FROM
    products
WHERE
    unit_price > 30;
	
SELECT
    AVG(shipped_date - order_date) -- количество дней на доставку.
FROM
    orders
WHERE
    ship_country = 'USA';
	
SELECT 
    SUM(unit_price * units_in_stock)
FROM
    products
WHERE
    discontinued <> 1;
	
	