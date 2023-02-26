
/*
ПРЕДСТАВЛЕНИЕ(VIEW)
VIEW - Представление виртуальной таблицы которое храниться в базе.

Типы VIEW:
1. Временные
2. Рекурсивные
3. Обновляемые
4. Матерелизуемые

Приимущества VIEW:
 1. Подменяет реальную таблицу тем самым скрывает логику агрегацию данных при работе ORM.
 2. Позволяет скрыть от пользователя столбцы и строки нескольких таблиц и выводить только для пользователя нужные данные.

Основные конструкции VIEW:

CREATE VIEW - Создание виртуальной таблицы
	CREATE VIEW <view name> AS
 	SELECT
		<column name>
 	FROM
        <table name>	
	[JOIN]
 	[WHERE]

ALTER VIEW - Переименовывание имени виртуальной таблицы
	ALTER VIEW <view name> RENAME TO <new view name>

CREATE OR REPLACE VIEW - Замена виртуальной таблицы на новую, если виртуальной таблицы с указаным именем то создаеться новая таблица.
	CREATE OR REPLACE VIEW <view name> AS
    SELECT
		<column name> // состав колонок должен остаться прежний
 	FROM
        <table name> // состав таблиц должен остаться прежний	
	[JOIN]
 	[WHERE] // Условия можно менять
!Для глобального изменения виртуальной таблицы ее необходимо удалить и создать заново!

DROP VIEW - Удаление виртальной таблицы
DROP VIEW [IF EXISTS] <view name>

INSERT INTO - Вставка данных через представление.
INSERT INTO <view name>
WITH LOCAL CHECK OPTION // Запрещает вставку данных протеворечивающую условию представления.
WITH CASCADE CHECK OPTION // Запрещает вставку данных протеворечивающую условию родительского представления.

DELITE FROM - Удаление данных через представление с физической таблицы, только которые есть в представлении.
DELITE FROM <view name>
[WHERE] // без условия удаляться в данные с физической таблицы, которые есть в представлении.

!Модификация данных через представление не доступна при следующих условиях:!
	1. Только если в запросе используется одна таблица.
	2. В запросе не используються DISTINCT, GROUP BY, HAVING, UNION, ITERSECT, EXCEPT, LIMIT.
	3. В запрос не используються агрегатные функции MIN, MAX, SUM, COUNT, AVG.
	
!Можно создовать представление на основе представления.!	
*/

-- Создание и удаление представления.
CREATE VIEW products_suppliers_categories AS
SELECT
    products.product_name,
	suppliers.company_name,
	categories.category_name
FROM
	products AS products
	INNER JOIN suppliers AS suppliers
	ON products.supplier_id = suppliers.supplier_id
	INNER JOIN categories AS categories
	ON products.category_id = categories.category_id
;

SELECT
	*
FROM
	products_suppliers_categories
;

DROP VIEW IF EXISTS products_suppliers_categories

-- Создание представления и замена представления с новым условием.
CREATE VIEW heavy_orders AS
SELECT
	*
FROM
	orders
WHERE
	freight > 50
;

CREATE OR REPLACE VIEW heavy_orders AS
SELECT
	*
FROM
	orders
WHERE
	 freight > 100
WITH LOCAL CHECK OPTION	 
;

SELECT
	*
FROM
    heavy_orders
	
-- Переименование существующего представления
ALTER VIEW products_suppliers_categories RENAME TO psc_old
;

SELECT
	*
FROM
	psc_old
;

-- Вставка данных в физическую таблицу через представление
SELECT
    MAX(order_id)
FROM
    orders
;

INSERT INTO heavy_orders
VALUES(11078, 'VINET', 5, '2023-02-01', '2023-02-06', '2023-02-05', 1, 120,
	  'Hanari Carnes', 'Rua do Paco', 'Bern', null, 3012, 'Switzerland')
;

-- Вставка данных не соотвеcтвующая фильтру представления
INSERT INTO heavy_orders
VALUES(11080, 'VINET', 5, '2023-02-01', '2023-02-06', '2023-02-05', 1, 70,
	  'Hanari Carnes', 'Rua do Paco', 'Bern', null, 3012, 'Switzerland')
;

-- Удаление данных в физическую таблицу через представление
SELECT
	MIN(freight)
FROM
	heavy_orders	
;

-- Удаление записи связанной таблицы
DELETE FROM order_details
WHERE order_id = 10854
;

DELETE FROM heavy_orders
WHERE heavy_orders.freight < 100.25
;

SELECT
	MIN(freight)
FROM
	orders	
;

