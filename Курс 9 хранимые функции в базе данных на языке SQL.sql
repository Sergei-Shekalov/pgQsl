
/*
PgSQL - Основан на архитикуре MVCC.
	MVCC - Multi Version Concurrency Control по сути «Одна строка имеет несколько версий».
		   При изменении записи в таблице, PgSQL сохраняет старую версию с пометкой unused, а пользователю доступна только новая запись. 
Кортеж - Это строка записи в базе данных.
Функции - Возвращает значения.

В основном используються функции PgSql.
Хранение кода который работает с данными, правильние ближе к данным(SRP).
Управление безопастностью выполняеться через регулирование доступом к функциям.
PgSql используеться модульное программирование. Модулями являються Функции.

Функции содержат (CRUD) операции к ним относяться SELECT, INSERT, UPDATE, DELETE.
Функции не могут содержать COMMIT, SAVEPOINT, VACUUM 
	COMMIT - зафиксировать транзакцию.
	SAVEPOINT - позволяет откатить транзакцию.
	VACUUM - удаляет устаревшие записи с в таблице.
		PgSQL - Основан на архитикуре MVCC.
			MVCC - Multi Version Concurrency Control по сути «Одна строка имеет несколько версий».
				Изменении записи в таблице приводит, сохранению старой версии записи с пометкой unused.
Транзакция в функции работает как SAVEPOINT, тоесть при ошибки в функии изменения откатываються.

Языки функций:
	- SQL функции
	- Процедурные(PL/pqSQL - основной диалект)
	- Серверные функции(написанные на С)
	- Собственные С - функции
	
*/

/*
Основные конструкции с использованием языка SQL:

CREATE FUNCTION - Создание функции.
	CREATE FUNCTION <function name(<arguments> <arguments name> <type>)>
	
	Аргументы:
	IN - Входящие аргументы.
		Используеться по умолчанию.
		Имя входящего параметра не должно совподать с именем поля для установки фильтра.
	OUT - Исходящие аргументы.
	INOUT - Входящие и Исходящие аргументы. Такой вид аргументов не нужно использовать.
	VARIADIC - Массив входящих параметров.
	DEFAULT - Для установки значения по умолчанию.
    !Обязательно после имени аргумента указывать его тип!
	
CREATE OR REPLACE FUNCTION - Модификация существующей функции, если функции нет то создание функции.
	CREATE OR REPLACE FUNCTION<function name>
RETURNS - Возвращает указанный тип значения
	RETURNS <return type>
	
	Типы:
	void - пустой тип, используеться когда функция не чего не возвращает, а только обрабатывает данные.
	
	Возврат множества строк:
	RETURNS SETOF <return type> - возврат любого количества строк одной колонки.
	
	RETURNS SETOF <table name> - возращает все столбцы из таблицы
	
	RETURNS SETOF RECORD - возвращает набор колонок с не известным типом. Используеться только в крайних случаях.
	Возврат через OUT - Параметры. Возврат одной строки с нескольками значениями. Только с использованием RETURNS SETOF record  
	
	RETURNS TABLE() - тоже что и RETURNS SETOF table, но имеет возможность явного указания возвращаемых столбцов.
	
AS - Описывает логику функции
	AS $$ <logic> $$
	
LANGUAGE Устанавливает язык функции
	LANGUAGE <lang>
	
!Возврат результата выполняется через SELECT!

Пример:
CREATE [OR REPLACE] FUNCTION <function name(<arguments>)> RETURNS <return type> AS $$
	--Описание логики функции
$$ LANGUAGE <lang>
	
*/

--Практические примеры с использованием функций на языке SQL
--Создание функции.
SELECT
	*
FROM customers;

SELECT
	*
INTO tmp_customer
FROM customers
;

--Функция которая не чего не возвращает, а только обрабатывает данные.
CREATE OR REPLACE FUNCTION fix_customer_region() RETURNS void AS $$
	UPDATE tmp_customer
	SET 
		region = 'unknown'
	WHERE
		region IS NULL
$$ LANGUAGE SQL
;

SELECT fix_customer_region()
;

SELECT
	*
FROM tmp_customer
;

--Скалярные функции, возращает одно значение, если будет несколько строк в столбце то вернет значение первой строки
CREATE OR REPLACE FUNCTION get_total_namber_of_goods() RETURNS bigint AS $$
	SELECT
		SUM(units_in_stock)
	FROM	
		products
$$ LANGUAGE SQL
;

SELECT get_total_namber_of_goods() AS total_goods
;

CREATE OR REPLACE FUNCTION get_avg_price() RETURNS float8 AS $$
	SELECT
		AVG(unit_price)
	FROM
		products
$$ LANGUAGE SQL
;

SELECT get_avg_price() AS avg_price
;

CREATE OR REPLACE FUNCTION get_test() RETURNS int AS $$
	SELECT
		3
	UNION ALL	
	SELECT
		1
$$ LANGUAGE SQL
;

SELECT get_test()
;

--Скалярная функции, возращает одно значение, с входящим аргементов.
CREATE OR REPLACE FUNCTION get_product_price_by_name(prod_name varchar) RETURNS real AS $$
	SELECT
		unit_price
	FROM
		products
	WHERE
		product_name = prod_name
$$ LANGUAGE SQL;

SELECT get_product_price_by_name('Chocolade')
;

--Функция с исходящими аргументами, используеться без указания RETURNS. 

CREATE OR REPLACE FUNCTION get_price_boundaries(OUT max_price real, OUT min_price real) AS $$
	SELECT
		MAX(unit_price),
		MIN(unit_price)
	FROM
		products
$$ LANGUAGE SQL
;

SELECT get_price_boundaries();
SELECT
	*
FROM 
get_price_boundaries()
;

--Функция с входящими и исходящими аргументами, используеться без указания RETURNS.
---Имя входящего параметра не должно совподать с именем поля для установки фильтра.
DROP FUNCTION get_price_boundaries_by_discontinued(int)
;

CREATE OR REPLACE FUNCTION get_price_boundaries_by_discontinued(is_discontinued int, OUT max_price real, OUT min_price real) AS $$
	SELECT
		MAX(unit_price),
		MIN(unit_price)
	FROM
		products
	WHERE
		discontinued = is_discontinued 
$$ LANGUAGE SQL
;

SELECT
	*
FROM
	get_price_boundaries_by_discontinued(1)
;

--Функция с входящим аргументом по умолчанию и исходящими аргументами, используеться без указания RETURNS.
CREATE OR REPLACE FUNCTION get_price_boundaries_by_discontinued(is_discontinued int DEFAULT 0, OUT max_price real, OUT min_price real) AS $$
	SELECT
		MAX(unit_price),
		MIN(unit_price)
	FROM
		products
	WHERE
		discontinued = is_discontinued 
$$ LANGUAGE SQL
;

SELECT
	*
FROM
	get_price_boundaries_by_discontinued(1)
;

--Функции с возвратом множества строк

--Функция с возратом множества строк по одной колонки
CREATE OR REPLACE FUNCTION get_averages_by_prod_categories()
		RETURNS SETOF double precision AS $$
	SELECT
		AVG(unit_price)
	FROM
		products
	GROUP BY
		category_id
$$ LANGUAGE SQL		
;

SELECT
	*
FROM
	get_averages_by_prod_categories()
;

--Функция с возвратом множества строк по нескольким колонкам через OUT параметры. 
CREATE OR REPLACE FUNCTION get_averages_by_prod_cats(OUT sum_pcice real, OUT avg_price float8)
		RETURNS SETOF RECORD AS $$
	SELECT
		SUM(unit_price),
		AVG(unit_price)
	FROM
		products
	GROUP BY
		category_id
	ORDER BY
		category_id
$$ LANGUAGE SQL		
;

SELECT 
	*
FROM
	get_averages_by_prod_cats()
;

--Обращение строго по имени OUT параметра.
SELECT 
	sum_pcice,
	avg_price
FROM
	get_averages_by_prod_cats()
;

--Функция с возвратом множества строк по нескольким колонкам без OUT параметров.
DROP FUNCTION get_averages_by_prod_cats_not_out()
;
CREATE OR REPLACE FUNCTION get_averages_by_prod_cats_not_out()
		RETURNS SETOF RECORD AS $$
	SELECT
		SUM(unit_price),
		AVG(unit_price)
	FROM
		products
	GROUP BY
		category_id
	ORDER BY
		category_id
$$ LANGUAGE SQL		
;

--Простая выборка для такой функции не работает
SELECT 
	*
FROM
	get_averages_by_prod_cats_not_out()
;

SELECT 
	sum_price,
	avg_price
FROM
	get_averages_by_prod_cats_not_out()
;

--Выборка с указанием явных типов параметров
SELECT 
	sum_price,
	avg_price
FROM
	get_averages_by_prod_cats_not_out() AS (sum_price real, avg_price float8)
;

/*
Функция с возвратом множества строк по нескольким колонкам через таблицу с явным указанием возращаемых колонок. 
Нужно строго следить за последовательностью полей между выборкой и возвратом.
Количество возвращаемых столбцов должно совподать с количиством выборке.
*/
CREATE OR REPLACE FUNCTION get_customers_by_country(customer_country char) 
		RETURNS TABLE(char_code char, company_name varchar) AS $$
	SELECT	
		customer_id,
		company_name
	FROM
		customers
	WHERE
		country = customer_country 
$$ LANGUAGE SQL		
;		

SELECT
	*
FROM
    get_customers_by_country('USA')
;	

SELECT
	company_name
FROM
    get_customers_by_country('USA')
;

SELECT
	char_code,
	company_name
FROM
    get_customers_by_country('USA')
;

-- Функция с возвратом множества строк таблицы. Обязательно выбирать все записи таблицы при возврате таблицы.
CREATE OR REPLACE FUNCTION get_emploee_table(manager int) 
		RETURNS SETOF emploee AS $$
	SELECT	
		*
	FROM
		emploee
	WHERE
		manager_id = manager 
$$ LANGUAGE SQL		
;

SELECT
	emploee_id,
	CONCAT(first_name, ' ', last_name),
	first_name || ' ' || last_name || ' ' || ' test' 
FROM
	get_emploee_table(1)
;

SELECT
	*
FROM
	get_emploee_table(1)
;	