/*
PgSQL - Основан на архитикуре MVCC.
	MVCC - Multi Version Concurrency Control по сути «Одна строка имеет несколько версий».
		   При изменении записи в таблице, PgSQL сохраняет старую версию с пометкой unused, а пользователю доступна только новая запись. 
Кортеж - Это строка записи в базе данных.
Функции - Возвращает значения.

PgSql в основном используються функции а не процедуры.
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

!Не следует процедурную логику размещать в базе данных!
!SQL язык работы с кортежами данных, лучше лишний раз не использовать процедурные расширения!. 
!Пременять pасширение pgplSQL нужно только крайнем случае!
*/

/*
Основные конструкции с использованием языка plpgSQL:
!Доступно использования процедурного языка!

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
	AS $$ <procedure body> $$

DECLARE - В данной секции создаються переменные врамках функции. 
BEGIN - Начало процедуры
	Использования условий и циклов.
	
	IF - Условие в процедуре, служит для определения результата.
		IF <if> WHEN <result>
		[ELSEIF <if> WHEN <result>]
		END IF;
	
	WHILE, LOOP, FOR - Цикл в процедуре служит для выполнения кода множество раз.
					   !Циклы в pgSQL лучше не использовать, лучше использовать запросы!
	
	WHILE - Простой цикл Пока. Цикл работает пока условие выполняеться.
		WHILE <if>
	    LOOP
			<logic>
		END LOOP;
	
	LOOP - Бесконечный цикл с условием выхода. Цикл прекращает свою работу только в том случае, когда выполняется условие выхода с цикла.
		LOOP
			EXIT WHEN <if>;
			<logic>
		END LOOP;
	
	FOR - Цикл со счетчиком, работает пока счетчик не достигнет максимального указанного значения. 
		Похож на цикл <Для Каждого>. Счетчик автоматически увеличивает значение при каждой итерации.
		REVERSE - Позволят выполнят цикл на убывание.
		FOR <counter> IN 1..5 [IN REVERSE 5..1]
		LOOP
			<logig>;
		END LOOP;
	EXIT, EXIT WHEN, RETURN - Выполняет прирывание выполнения цикла, описывается в теле цикла.
	
END - Окончание процедуры
	[DECLARE]
		<arguments>
	BEGIN 
		<logic> 
	END; 

LANGUAGE Устанавливает язык функции
	LANGUAGE <lang>

!Возврат результата выполняется через RETURN или RETURN QUERY(в дополнение к SELECT)!

Пример:
CREATE [OR REPLACE] FUNCTION <function name(<arguments>)> RETURNS <return type> AS $$
    [DECLARE]
	--Описание переменных 
	BEGIN
	--Описание логики функции
	END;
$$ LANGUAGE <lang>	
*/

/*
Анонимный блок кода
DO - Создание анонимного блока кода.
	DO $$
		BEGIN
			<logic>
		END;
	END $$;
!Используеться в основном для тестирования!	
*/

/*
Построчный процессинг

RETURN NEXT - Выполняет возврат и накапливание построчного результата.
RETURN NEXT <result>; 

*/

--!Не следует процедурную логику размещать в базе данных!

--Практические примеры с использованием функций на языке plpgSQL

CREATE OR REPLACE FUNCTION get_total_of_goods() RETURNS bigint AS $$
BEGIN
	RETURN 
		SUM(units_in_stock)
	FROM 
		products;
END;
$$ LANGUAGE plpgSQL
;

SELECT get_total_of_goods()
;

CREATE OR REPLACE FUNCTION get_max_price_discontinued() RETURNS real AS $$
BEGIN
	RETURN 
		MAX(unit_price)
	FROM 
		products
	WHERE
	    discontinued = 1;
END;
$$ LANGUAGE plpgSQL
;

SELECT get_max_price_discontinued()
;

--Функции возрат значение через OUT параметры
-- Такой способ выполняет два раза запрос к базе данных.
CREATE OR REPLACE FUNCTION get_price_boundaries_1(OUT max_price real, OUT min_price real) AS $$
BEGIN
	max_price = MAX(unit_price) FROM products;
	min_price = MIN(unit_price) FROM products;
END;
$$ LANGUAGE plpgSQL
;

SELECT * FROM get_price_boundaries_1();

--Такой способ выполняет один запрос к базе данных.
CREATE OR REPLACE FUNCTION get_price_boundaries_2(OUT max_price real, OUT min_price real) AS $$
BEGIN
	SELECT
		MAX(unit_price),
		MIN(unit_price)
	INTO
		max_price, -- Указываем имя исходящего аргуемента
		min_price --  Указываем имя исходящего аргуемента
	FROM
		products
	;	
END;
$$ LANGUAGE plpgSQL
;

SELECT * FROM get_price_boundaries_2();

--Функция возрат значение череp OUT параметры с использованием IN параметров. 
CREATE OR REPLACE FUNCTION get_sum(x int, y int, OUT result int) AS $$
BEGIN
	result = x + y;
	RETURN; -- Это возврат и функции.
END;
$$ LANGUAGE plpgSQL
;

SELECT get_sum(1, 2);

--Функция множественного возрата всех столбцов таблицы.
CREATE OR REPLACE FUNCTION get_customers(customer_country varchar) RETURNS SETOF customers AS $$
BEGIN
	RETURN QUERY
    SELECT
		*
	FROM 
		customers 
	WHERE 
		country = customer_country; 
END;
$$ LANGUAGE plpgSQL
;

SELECT
	*
FROM
	get_customers('USA')
;

--Функции с использованием переменных.

--Функция вычисления площадь триугольника по трем сторонам.
CREATE OR REPLACE FUNCTION get_square(ab real, bc real, ac real) RETURNS real AS $$
	DECLARE
		perimeter real;
	BEGIN
		perimeter = (ab + bc + ac); 
		RETURN sqrt(perimeter * (perimeter - ab) * (perimeter - bc) * (perimeter- ac));
	END;
$$ LANGUAGE plpgSQL 
;

SELECT get_square(6,6,6);

--Функция вычисления среднию цену по продуктам, и возмем кооэфицент для вычисления границ.
CREATE OR REPLACE FUNCTION calc_middle_price() RETURNS SETOF products AS $$
	DECLARE
		avg_price real;
		low_price real;
		high_price real;
	BEGIN
	    SELECT
			AVG(unit_price)
		INTO
			avg_price
		FROM
			products;
		
		low_price  = avg_price * 0.75;
		high_price = avg_price * 1.25;
		
		RETURN QUERY
		SELECT
			*
		FROM
			products
		WHERE
			unit_price BETWEEN low_price AND high_price
		;	
	END;
$$ LANGUAGE plpgSQL
;

SELECT
	*
FROM
	calc_middle_price()
;

--Функции с использованием условия if

--Функция пересчета форенгейты в градусы цельсия.
CREATE OR REPLACE FUNCTION cinvert_temp_to(temperature real, to_celsius bool DEFAULT true) RETURNS real AS $$ 
DECLARE
	result_temp real;
BEGIN
	IF to_celsius THEN
		result_temp = (5.0 / 9.0) * (temperature - 32);
	ELSE
		result_temp = (9 * temperature +(32 *5)) / 5.0;
	END IF;
	RETURN result_temp;
END;
$$ LANGUAGE plpgSQL
;

SELECT cinvert_temp_to(80);
SELECT cinvert_temp_to(26.6666, false);

--Функция вычисления по номеру месяца, время года.
DROP FUNCTION get_saason() ;

CREATE OR REPLACE FUNCTION get_season(month_number int) RETURNS text AS $$
DECLARE
	season text;
BEGIN
	
	IF month_number BETWEEN 3 AND 5 THEN
		season = 'Spring';	
	ELSEIF month_number BETWEEN 6 AND 8 THEN
		season = 'Summer';
	ELSEIF month_number BETWEEN 9 AND 11 THEN
		season = 'Autumn';
	ELSE
		season = 'Winter';
	END IF;
	
	RETURN season;
	
END;
$$ LANGUAGE plpgSQL
;

SELECT get_season(9);

--Функции с использованием циклов.

--Функция вычисление числа по последовательности фибоначи. Использования цикла Пока.
CREATE OR REPLACE FUNCTION fib1(n int) RETURNS int AS $$
DECLARE
	counter int = 0;
	i int = 0;
	j int = 1;
BEGIN
	IF n < 1 THEN
		RETURN 0;
	END IF;
	
	WHILE counter < n
	LOOP
		counter = counter + 1;
		SELECT
			j, i + j
		INTO
			i, j;
	END LOOP;
	
	RETURN i;
	
END;
$$ LANGUAGE plpgSQL
;

SELECT fib1(3);

--Функция вычисление числа по последовательности фибоначи. Использования бесконечного цикла с условием выхода.
CREATE OR REPLACE FUNCTION fib2(n int) RETURNS int AS $$
DECLARE
	counter int = 0;
	i int = 0;
	j int = 1;
BEGIN
	IF n < 1 THEN
		RETURN 0;
	END IF;
	
	LOOP
		EXIT WHEN counter > n;
			counter = counter + 1;
		SELECT
			j, i + j
		INTO
			i, j;
	END LOOP;
	
	RETURN i;
	
END;
$$ LANGUAGE plpgSQL
;

SELECT fib2(6); 

--Анонимный блок кода, используеться для проверки.
DO $$
BEGIN
	FOR counter IN 1..5
	LOOP
		RAISE NOTICE 'Counter: %', counter;
	END LOOP;
END
$$;

DO $$
BEGIN
	FOR counter IN REVERSE 5..1
	LOOP
		RAISE NOTICE 'Counter: %', counter;
	END LOOP;
END
$$;

--Построчный процессинг
CREATE OR REPLACE FUNCTION return_ints() RETURNS SETOF int AS $$
	BEGIN
		RETURN NEXT 1;
		RETURN NEXT 3;
		RETURN NEXT 5;
		RETURN NEXT 7;
	END;
$$ LANGUAGE plpgSQL
;

SELECT return_ints();

CREATE OR REPLACE FUNCTION after_christmas_sale() RETURNS SETOF products AS $$
DECLARE
	product record;
BEGIN
	FOR product IN SELECT * FROM products
	LOOP
		
		IF product.category_id IN (1, 4, 8) THEN
			product.unit_price = product.unit_price * 0.8;	
		ELSEIF product.category_id IN (2, 3, 7) THEN
			product.unit_price = product.unit_price * 0.75;
		ELSE
			product.unit_price = product.unit_price * 1.1;
		END IF;
		
		RETURN NEXT product;
	
	END LOOP;
END;
$$ LANGUAGE plpgSQL
;

SELECT
	*
FROM
	after_christmas_sale()
;