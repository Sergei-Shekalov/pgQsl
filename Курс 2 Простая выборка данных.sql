/*
Типы данных в значении колонок
1. Пустая строка - это данные пустая строка.
2. NULL - отсуствие данных.
*/

/*
Последовательность выполнения конструкций
1. Блок FROM
2. Блок WHERE
3. Блок GROUP BY
4. Блок HAVING
5. Блок SELECT
6. Блок UNION, INTERSECT, ECXEPT
7. Блок ORDER BY

!Латинскими цыфрами будет указана последовательность выполнения блоков!
*/

/*
Основные конструкции:
(V)
SELECT - Ключевое слово для выборки данных.
SELECT TOP <number> - Ключевое слово для указания количество строк выборки. Работает в SQL Server.
SELECT DISTINCT - Ключевое слово для выборки различных данных используется вместе с SELECT. 
    * - Все колонки таблицы,
    <column name> - Имя колонки, если используется один источник данных. 
    <table name>.<column name> - Имя таблицы и через точку имя колонки, если используется один или несколько источников данных.
    text, int, Boolean - Произвольные значения этих типов можно указывать без источника данных.
	
    Агрегатные функции:
	Агрегатные функции функции могут использоваться как отдельно так совместно с группировками по полям.
	
    COUNT() - Функция для подсчета количества строк в колонке
          * - Подсчет строк по всем колонкам таблицы
          <column name> - Подсчет строк по колонке таблицы
    COUNT (DISTINT <column name>) - Подсчет уникальных значений по колонке таблицы, количество различных.
    MAX(<column name>) - Получает максимальное уникальное значение.
    MIN(<column name>) - Получаем минимальное уникальное значение.

    AVG(<column name>) - Получаем среднее значение, работает с типом число(integer).
    SUM(<column name>) - Получаем сумму по колонке, работает с типом число(integer).
	
	Псевдонимы
	
	AS - Назначает псевдоним колонки 
	<column name> AS <new column name>
	• - Через пробел можно назначить псевдоним колонки
	<column name>•<new table name>
	
	Псевдонимы колонок можно использовать следующих частях запроса
    
	Полезные функции:
	CONCAT() - соединяет строки
		CONCAT(text1, ' ', text2),
		<text1> || ' ' || <text2> || ' ' || ' <text3>'
	:: - изменяет значение типа колонки при чтении данных. 
		<column name> :: <new type> 

INTO - Создание временной таблицы
INTO <temporary table name>

(I)
FROM - Kлючевое слово для указания источника данных выборки.
    <table name> - Имя таблицы источника данных.
    
	Псевдонимы
	
	AS - Назначает псевдоним таблицы 
	<column name> AS <new column name>
	• - Через пробел можно назначить псевдоним таблицы
	<column name>•<new table name>

(II)
WHERE - Kлючевое слово для указания первичного фильтра для выборки данных.
     
	 Операторы сравнения:
	 Значение дат устанавливается через летерал '' по формату даты.
	 <column name> =  <data value>
	 <column name> <> <data value>
	 <column name> >  <data value>
	 <column name> <  <data value>
	 <column name> >= <data value>
	 <column name> =< <data value>
	 
	 Логические операторы:
	 OR - Логическое ИЛИ.
	 AND - Логическое И.
	 При использовании связки AND,OR нужно отделить условия скобками. 
	 <column name> < <data value> АND (<table name> >  <data value> OR <table name> >= <data value>)
	 
	 Оператор для работы с интервалами включеными границами:
	 BETWEEN - Оператор между, данный оператор включает границы значений.
	 <column name> BETWEEN <data value> АND (<table name>;
	
	 Оператор сравнения набора или перечиления
	 IN - Указываються значения которые необходимо выбрать
	 
	 Оператор отрицания
	 NOT - Оператор Не.
	 NOT <column name> IN (<data value>, <data value>)
     <column name> NOT IN (<data value>, <data value>)
	 
	 Оператор поиска значения по шаблону
	 LIKE - Оператор подобно.
	 <column name> LIKE <pattern>
	 Шаблоны:
	 % - означает любое количество символов.
	 '<meaning>%' - строки, начинающиеся с указаного значения.
	 '%<meaning>' - строки, оканчивающиеся с указаного значения.
	 '%<meaning>%' - строки, содержащие указанное значение.
	 '<meaning1>%<meaning2>' - строки, начинающиеся с указаного значения1 и оканчивающиеся с указаного значения2.  
	 _ - означае один символ.
	 '_<meaning>_' - строки, где 1 и 3 символы любые, 2 указаное значение.
	 '_<meaning>%<' - строки, где 1 любой символ 2 указаное значение, 3 более любых символов. 
	 
	 Оператор поиска отсуствующих данных
	 IS NULL
	 <column name> IS NUL
	 
	 Опереторы для работы с подзапросами:
	  
	 1. Оператор сравнения набора или перечиления
	 IN - Указываються значения которые необходимо выбрать
	 Отберет только те значения которые есть в наборе или в перечислении. 
	 Эквевалентен логическому оператору OR. 
	 <column name> IN (<data value>, <data value>)
     <column name> IN (SELECT <column name> FROM <table name>)
	 
	 2. Операторы сравнения
	 =, <>, >, <, >=, =<
     <column name> =, <>, >, <, >=, =< (SELECT <column name> FROM <table name>)
	 
	 3. Оператор отрицания
	 NOT
	 NOT IN(SELECT <column name> FROM <table name>)
	 NOT EXISTS (SELECT <column name> FROM <table name>)
	 NOT <column name> = ANY(SELECT <column name> FROM <table name>)
	 NOT <column name> = ALL(SELECT <column name> FROM <table name>)
	 
	 4. Оператор проверки заполнености набора или таблицы
	 EXISTS
	 Возращающий true если есть хоть одна запись в наборе или таблице иначе false.
	 EXISTS (SELECT <column name> FROM <table name>)
	 
	 5. Оператор сравнения набора.
	 ANY
	 Возращающий true если есть хоть одна запись в наборе удовлеворяющие условию иначе false.
	 Отберет значения с основной выборки если хоть одно значение с набора удовлетворяют условию. 
	 Эквивалентен логическому оператору OR  
	 Можно использовать с операторами сравнения =, <>, >, <, >=, =<  
	 Эквевалентен при сравнении = ANY() опретору IN()
	 <column name> ANY (SELECT <column name> FROM <table name>)
	 
	 6. Оператор сравнения набора.
	 ALL
	 Возращающий true если все записи в наборе удовлеворяющие условию, иначе false.
     Если набор пустой по умочанию вернет true.
	 Отберет значения с основной выборке если все значения с набора удовлетворяют условию.
	 Эквивалентен логическому оператору AND
	 Можно использовать с операторами сравнения =, <>, >, <, >=, =< в основном используются >, <, 
     <column name> ALL (SELECT <column name> FROM <table name>)

(III)
GROUP BY - Ключевое слово для группировки значений, также используется совместно с агрегатными фукциями.

(IV)
HAVING - Kлючевое слово для указания вторичного фильтра на результат сгруппированых данных. 

(VII)
ORDER BY - Ключевое слово для указания сортировки значений колонки. Сортировка по умолчанию по возрастанию.
     Виды сортировок
     <column name> ASC  - возрастание
	 <column name> DESC - убывание

(VI)
Операции на множествах: 
Используются между результами выборок. 
UNION - Ключевое слово для объединения результатов выборок без дубликатов.
UNION ALL - Ключевое слово для объединения результатов выборок всех записей включая дубликаты.
INTERSECT - Ключевое слово которое выводит пересекающиеся записи результатов выборок. 
EXCEPT    - Ключевое слово которое выводит исключения записей результатов выборок которые есть в левой выборке,
            но приэтом отсутвуют в правой выборке.
ECXEPT ALL - Ключевое слово которое выводит исключения записей результатов выборок которые есть в левой выборке,
             а также разницу строк значений присутвующих в левой и правой выборке. 			
Исключение 
LIMIT <number> - Ключевое слово для указания количество строк выборки.

Последовательность выполнение ключевых частей запроса:
1. Блог FROM
2. ON
3. JOIN
4. Блог WHERE
5. Блог GROUP BY (Позволяет использовать псевдонимы полей)
6. Блог HAVING
7. Функции WINDOW
8. Блог SELECT
9. DICTINCT
10. Блог UNION, INTERSECT, EXCEPT
11. Блог ORDER BY (Позволяет использовать псевдонимы полей)
12. LIMIT, TOP
*/

SELECT * 
FROM products;

SELECT 
   product_id, 
   product_name,
   unit_price
FROM products;

SELECT 
   product_id AS product_id_test, 
   product_name AS product_name_test,
   sum(unit_price) AS unit_price_sum
FROM products
GROUP BY
   product_id_test,
   product_name_test
HAVING
   unit_price_sum = 10
;

-- Математические операции
SELECT
   product_id,
   product_name,
   unit_price * units_in_stock
FROM
    products;

-- Выборка уникальных значений.
SELECT DISTINCT city, country
FROM
    employees;
	
--------------------
-- Агрегатные функции:
-- Подсчет количества всех строк в таблице. 
SELECT
    COUNT(*),
	COUNT(order_id)
FROM 
    orders;
	
-- Подсчет только уникальных строк в колонке
SELECT
    COUNT(DISTINCT Country)
FROM
    employees;

-- Возвращает максимальное значение
SELECT
    max(employee_id)
FROM
    employees;

-- Возвращает минимальное значение
SELECT
    min(employee_id)
FROM
    employees;

--------------------

/*
Условия запроса с логическими операторами ">, >=, <, <=, =, <>" оператором	
*/

-- Оператор сравнения =
SELECT
    company_name,
	contact_name,
	phone,
	country
FROM
    customers
WHERE
    country = 'USA'; 

-- Оператор сравнея >
SELECT *
FROM
    products
WHERE
    unit_price > 20;

-- Оператор сравнея <
SELECT *
FROM
    products
WHERE
    unit_price < 20;

-- Оператор сравнея >, агрегатная функция подсчета количества.  
SELECT COUNT(*)
FROM
    products
WHERE
    unit_price > 20;

--------------------

-- Оператор сравнея <, агрегатная функция подсчета количества.  
SELECT COUNT(*)
FROM
    products
WHERE
    unit_price < 20;
	
SELECT *
FROM
    products
WHERE
    discontinued = 1;
	
SELECT *
FROM 
    customers
WHERE
    city <> 'Berlin';
	
SELECT *
FROM 
    orders
WHERE
    order_date > '1998-03-01'; -- Дата устанавливается через летерал ''

SELECT *
FROM
    products
WHERE
    unit_price > 25 AND units_in_stock > 40; 

SELECT *
FROM 
    customers
WHERE
   city = 'Berlin' OR city = 'London' OR city = 'San Francisco';
   
SELECT *
FROM
    orders
WHERE
 shipped_date > '1998-04-30' AND (freight < 75  OR freight < 150);

--------------------

/*
Условия запроса с оператором BETWEEN
Два запроса возвращают одинковые значения 
*/
SELECT 
    COUNT(*)
FROM
    orders
WHERE
    freight >= 20 AND freight <= 40;
-- the same with BETWEEN including boundaries
SELECT
    COUNT(*)
FROM
    orders
WHERE
    freight BETWEEN 20 AND 40;
	
SELECT *
FROM
    orders
WHERE
    order_date BETWEEN '1998-03-30' AND '1998-04-03';

--------------------	

/*
Оператор IN
Два одинаковых разных запроса возвращают одинаковый результат.
*/	

SELECT *
FROM
    customers
WHERE
    country = 'Mexico' OR country = 'Germany' OR country = 'USA' OR country = 'Canada';

SELECT *
FROM
    customers
WHERE
    country IN('Mexico', 'Germany', 'USA', 'Canada');
	
SELECT *
FROM
    products
WHERE
    category_id IN(1, 6, 4);
	
--------------------

/*
Оператор отрицания NOT
*/

SELECT *
FROM
    customers -- таблица с клиентами
WHERE
    country NOT IN('Mexico', 'Germany', 'USA', 'Canada');
	
SELECT *
FROM
    products
WHERE
    category_id NOT IN(1, 6, 4);
	
--------------------	

/*
Сортировка значений
Ключевое слово ORDER BY 
*/

SELECT DISTINCT country, city
FROM
    customers
ORDER BY 
    country,
	city
	
--------------------	

/*
Скалярные функции MIN(), MAX(), AGV()
*/

SELECT
    MIN(order_date)
FROM
    orders
WHERE
    ship_city = 'London';
	
SELECT
    MAX(order_date)
FROM
    orders
WHERE
    ship_city = 'London';

SELECT
    AVG(unit_price)
FROM
    products
WHERE
    discontinued <> 1;
	
SELECT
    SUM(units_in_stock) as Сумма
FROM
    products
WHERE
    discontinued <> 1;

--------------------

/*
Оператор LIKE
*/

SELECT 
    last_name,
	first_name
FROM
    employees
WHERE
    first_name LIKE '%n';
	
SELECT 
    last_name,
	first_name
FROM
    employees
WHERE
    last_name LIKE 'B%';

SELECT 
    last_name,
	first_name
FROM
    employees
WHERE
    last_name LIKE 'Buch%';

SELECT 
    last_name,
	first_name
FROM
    employees
WHERE
    first_name LIKE '____e_';

--------------------

/*
Ключевое слово LIMIT
*/
SELECT
    *
FROM
    products
LIMIT 15;

SELECT
    *
FROM
    products
ORDER BY
    product_id DESC
LIMIT 15;

--------------------

/*
Оператор IS NULL
*/

SELECT
    *
FROM
    orders
WHERE
    ship_region IS NULL;

SELECT
    *
FROM
    orders
WHERE
     ship_region  IS NOT NULL;

--------------------

/*
Ключевое слово GROUP BY
*/

SELECT 
    ship_country,
	COUNT(*)
FROM
    orders
GROUP BY
    ship_country;

SELECT 
    ship_country,
	COUNT(*)
FROM
    orders
WHERE
    freight > 50
GROUP BY
    ship_country;
	
SELECT 
    ship_country,
	COUNT(*)
FROM
    orders
WHERE
    freight > 50
GROUP BY
    ship_country
ORDER BY
    COUNT(*) DESC;

SELECT
    category_id,
	SUM(units_in_stock)
FROM
    products
GROUP BY
    category_id;

SELECT
    category_id,
	SUM(units_in_stock)
FROM
    products
GROUP BY
    category_id
LIMIT 3;	
	
--------------------

/*
Ключевое слово HAVING
*/

SELECT
    category_id,
    SUM(unit_price * units_in_stock)
FROM
    products
WHERE
    discontinued <> 1
GROUP BY
    category_id
HAVING
    SUM(unit_price * units_in_stock) > 5000
ORDER BY
    SUM(unit_price * units_in_stock) DESC;

--------------------

/*
Операции над множествами:
Ключевое слов UNION,
Ключевое слов UNION ALL,
Ключевое слово INTERSECT,
Ключевое слов EXCEPT,
Ключевое слов EXCEPT ALL.
*/

-- UNION объеденяет данные выборок без дублей. 
SELECT
    country
FROM
    customers
UNION

SELECT
     country
FROM
    employees;

/* 
UNION ALL
Выбирает все записи с двух таблиц, 
условия в выборках влияют только на данные самой выборки а не на объединеные данные выборок, 
для объединеных данных нужно накладывать отдельные условия.   
*/
SELECT
    country
FROM
    customers
UNION ALL

SELECT
     country
FROM
    employees;	

/*
INTERSECT пересечение значения строк результат выборок,
если значение строк есть в результатах всех выборок, 
тогда значения будут выведены.  
*/

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
	
/*
EXCEPT выводит записи только те которые находяться в левой выборке и при этом отсутвуют в других выборках.
*/	

SELECT
    country
FROM
    customers

EXCEPT

SELECT
    country
FROM
    suppliers;

/*
EXCEPT ALL выводит записи те которые находяться в левой выборке,
а также разницу строк записей которые находятся в обоих выборках.
*/
SELECT DISTINCT
    *
FROM
(SELECT
    country
FROM
    customers

EXCEPT ALL

SELECT
    country
FROM
    suppliers) AS test;
	
SELECT
    country
FROM
    suppliers
WHERE
    country IN('Argentina', 'Switzerland', 'Venezuela');
	
	
