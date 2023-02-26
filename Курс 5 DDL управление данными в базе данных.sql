
/*
Проектирование базы данных:

Нормализацией - Приведение структуры базы данных к нормальным формам.
Нормализация таблиц к нормальным формам основана на дикомпозиции.

1.НФ(Нормальная форма)
  Правила:
  1. Строки таблицы не содержат дубликатов
  2. Все колонки таблицы простых типов
  3. В каждое поле строк таблицы должно содержать по одному значению

2.НФ(Нормальная форма)
  Правила:
  1. Таблица должна соотвествовать 1НФ. 
  2. В таблице должнен быть первичный ключ. 
  3. Все атрибуты (поля) описывают первичный ключ целиком, а не лишь его часть.

3.НФ(Нормальная форма)
  1. Таблица должна соотвествовать 2НФ.
  2. Не должно быть зависимости одних не ключевых атрибутов от других. 
     Это когда данные связанные по смыслу лучше хранить в отдельной таблице. 

*/

/*

Для создания объектов и удаления:
IF EXISTS

Основные конструкции DDL:

CREATE TABLE - Ключевое слоово создает таблицу в базе данных.
	
	CREATE TABLE IF NOT EXISTS <table name> // Условие IF NOT EXISTS обязательно при создании таблицы.
	CREATE TABLE <table name>
	( 
	<column name> <date type>,
  	<column name> <date type>
	)

Ограничение колонок:
	
	PRIMARY KEY - Первичный ключ. Колонка в таблице с данным ограничением может быть только одна.
	              Контролирует уникальность значений в колонке. Запрещает вставлять значение NULL.
				  
	UNIQUE NOT NULL - Данное ограничение может использовать для любоко колества колонок в таблице.
	 				  Контролирует уникальность значений в колонке. 
	                  Запрещает вставлять в колонку значение NULL.
					  Почти эквевалентно ограничению PRIMARY KEY. 
	
	UNIQUE - Контролирует уникальность значений в колонке. 
	         Данное ограничение может использовать для любоко колества колонок в таблице. 
	
	FOREIGN KEY - Внешний ключ. Содержит значение первичного ключа другой таблицы.
	FOREIGN KEY(<constraint_name>) REFERENCES <column name pkey>
	
	NOT NULL - Запрещает вставлять в колонку значение NULL.

    CHECK - Содержит условие логиского ограничения колонки.
	CHECK(<if>)
	
	DEFAULT - Содержит значение по умолчанию, если значение не заполнено то будет установлено значение по умолчанию.
	DEFAULT(<value>)
	
ALTER TABLE - Ключевое слово изменяет структуру существующей таблицы
	
   ALTER TABLE <table name>
   
   Вспомогательные слова для работы:
   ADD COLUMN - Вспомогательное слово для добавления новой колонки
   ADD COLUMN <column name> <date date>
   
   ADD CONSTRAINT - Вспомогательное слово для добавления ограничение для колонки
   ADD <constraint_name> <column name>  
   
   RENAME TO - Вспомогательное слово для назначения нового имени
   RENAME TO <new table name> / назначение нового имени таблицы
   RENAME <new column name> TO <new column name> / назначение нового имени колонки таблицы
   
   ALTER COLUMN - Вспомогательное слово для изменения структуры колонки 
   ALTER COLUMN <column name> SET DATA TYPE <data type> / назначение нового типа для колонки
   ALTER COLUMN <column name> SET <constraint_name> / добавляет ограничение
   ALTER COLUMN <column name> DROP <constraint_name> / удаляет ограничение
	
   DROP COLUMN - Вспомогательное слово для удаления колонки с таблицы
   DROP COLUMN <column name>
   
   DROP CONSTRAINT - Вспомогательное слово для удаления ограничения в колонке
   DROP CONSTRAINT <constraint_name>
   
DROP TABLE - Ключевое слово для удаления таблицы с базы данных
	
	DROP TABLE IF NOT EXISTS <table name> // Условие IF NOT EXISTS обязательно при удалении таблицы.
	DROP TABLE <table name>

INSERT INTO - Ключевое слово для заполнения данных в таблицу

	OVERRIDING SYSTEM VALUE - Позволяет преопределить значения колонок с автонкриментом, 
                          	  При использовании конструкции GENERATED ALWAYS AS IDENTITY.

	OVERRIDING USER VALUE - Запрещает преопределить значения колонок с авто инкриментом, 
                            используеться при копировании данных в другую таблицу,
						    при этом данные с колонки с авто инкриментом не коприуються а генерируются последовательно.   

	INSERT INTO <table name>(<column name>) - если данные добавляются не восве колонки,
	VALUES                                    необходимо в скобках перечислить колонки в которые добавляются данные
      	(row value),
	  	(row value)
	
	INSERT INTO <table name> - Вставка данных с помощью выборки данных 
	SELECT
		*
	FROM
		<origin table name>
	WHERE 	
    	<if>
		
	SELECT - Копирование данных с одно таблицы в другую.
		*
    INTO
		<new table name>
    FROM
 		<origin table name>
	WHERE
    	<if>		

UPDATE - Ключевое слово для обновления данных в таблице. 

	UPDATE 
		<table name>
	SET 
		<сolumn name> = <new value>
	WHERE
    	<if> / Содержит условие для обновления данных
	
DELETE FROM - Ключевое слово для удаления всех данных с таблицы
               Работает медленее чем TRANCATE так как СУБД создает записи в log.   
	DELETE FROM <table name> / удаление всех данных с таблицы.
    
	DELETE FROM <table name> / удаление данных с таблицы по условию.
	WHERE <if> / Содержит условие для удаления данных
	
TRUNCATE TABLE - Ключевое слово для удаления всех данных с таблицы.
                 Работает быстрее чем DELETE так как СУБД не создает записи в log.
				 Не может удалить данные в таблице если есть ссылка на другую таблицу 
	TRUNCATE TABLE <table name>

    При использовании в таблице полей с типом авто инкриментам обязательно рестартить счетсчик.
    TRUNCATE TABLE <table name> RESTART IDENTITY

RETURNING - Возвращает результат от действий(INSERT, UPDATE, DELETE) 

Последовательность:

!Ручной ввод индетефикатора в колонку с авто инкрементом приводит к сбою счетчика и к ошибке!

Тип serial - Создает авто инкремент строк для указаной колонки таблицы, позволяет ручной ввод индетификатора. 

SEQUENCE - Последовательность, используется создания авто инкремента строк колонки таблицы, позволяет ручной ввод индетификатора. 

Функции для работы с последовательностями:
	nextval('<sequence name>') / Функция возвращает увеличенное значение счетчика последовательности по умолчанию + 1.
	                            Дубли последовательности исключены даже при вызове в разных сеансах.
	setval('<sequence name>', <bigint> [,< boolean>]) - Функция возвращает установленное значение.
	                                                Параметры:
													<sequence name> - имя последовательности
													<bigint> - значение последовательности
													< boolean> 
													Tru - указывает на то что при выполнении функции nexvel('<sequence name>'),
													      последовательность должна увиличиваться +1 и вернуть значение.
														  признак установлен по умолчанию.
													false - указывает на то что при выполнении функции nexvel('<sequence name>'),
													        последовательность должна вернуть устновленное значение.
															Только уже следующие вызовы функции nexvel('<sequence name>')
															увеличать последовательность.
														  
																 
	currval('<sequence name>') / Функция возвращает последнее значение переданной последовательности. 
	                             Если переданная последовательность не вызывалась в данном сеансе тогда вернет ошибку.  
	lastval() / Функция возвращает последнее значение вызываемой последовательностив данном сеансе.
	            Если не одна из последовательностей не вызывалась в данном сеансе тогда вернет ошибку.

Основные конструкции последовательности:

CREATE SEQUENCE - Создание последовательности.

	CREATE SEQUENCE <sequence name> / Создание последовательности.
	CREATE SEQUENCE IF NOT EXISTS <sequence name> INCREMENT <bigint> / Создание последовательности c шагом увиличения последовательности.

    / Создание последовательности и установка ее для колонки таблицы. В место использования типа serial
	CREATE SEQUENCE IF NOT EXISTS <sequence name>
	START WITH <bigint> OWNED BY <column name> / авто инкремент будет стартовать с указаного значение с шагом + 1.
	START WIHT <bigint1> INCREMENT BY <bigint2> OWNED BY <column name> /авто инкремент будет стартовать с указаного значение с указаным шагом.

	ALTER TABLE <table name>
	ALTER COLUMN <column name> SET DEFAULT nextvel('<sequence name>');
    \

ALTER SEQUENCE - Изменение последовательности.
	
	ALTER SEQUENCE <sequence name> RENAME TO <sequence new name> / Изменяет имя последовательности
	ALTER SEQUENCE <sequence name> RESTART WITH <bigint> / Рестартит значение последовательности

DROP SEQUENCE - Удаление последовательности.
	
	DROP SEQUENCE <sequence name> / Удаление последовательности.

	<column name> int GENERATED ALWAYS AS IDENTITY / устанавливает для поля авто инкремент, 
                                                 	 заприщает ручной ввод индетефикатора.
												 
	<column name> int GENERATED ALWAYS AS IDENTITY(START WIHT <bigint1> INCREMENT BY <bigint2> OWNED BY <column name>)

	<column name> int GENERATED BY DEFAULT AS IDENTITY / работает как тип serial.

*/

CREATE TABLE student
(
	student_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar 
)
;

CREATE TABLE cathedra
(
    cathedra_id serial,
	cathedra_name varchar,
	decan varchar
)
;

ALTER TABLE student
ADD COLUMN middle_name varchar
;
ALTER TABLE student
ADD COLUMN reting float
;
ALTER TABLE student
ADD COLUMN enrolled date
;

ALTER TABLE student
DROP COLUMN middle_name
;

ALTER TABLE cathedra
RENAME TO chair
;

ALTER TABLE chair
RENAME cathedra_id TO chair_id
;
ALTER TABLE chair	 
RENAME cathedra_name TO chair_name
;

ALTER TABLE student
ALTER COLUMN last_name SET DATA TYPE varchar(64)
;
ALTER TABLE student
ALTER COLUMN first_name SET DATA TYPE varchar(64)
;
ALTER TABLE student
ALTER COLUMN phone SET DATA TYPE varchar(30)
;

CREATE TABLE faculty
(
     faculty_id serial,
	 faculty_name varchar
)
;

INSERT INTO faculty (faculty_name)
VALUES
('faculty 1'),
('faculty 2'),
('faculty 3')
;

SELECT 
      *
FROM
    faculty
;	
	
TRUNCATE TABLE faculty RESTART IDENTITY
;

DROP TABLE faculty
;

--Ограничения
DROP TABLE IF EXISTS chair
;

CREATE TABLE chair
(
	chair_id serial PRIMARY KEY,
	chair_name varchar,
	dean varchar
)
;

INSERT INTO chair
VALUES(1, 'name 1', 'dean 1')
;

-- Позволяет получить наименование ограничения 
SELECT 
	constraint_name	
FROM 
	information_schema.key_column_usage
WHERE
	table_name = 'chair'
	AND table_schema = 'public'
	AND column_name = 'chair_id'
;	

DROP TABLE IF EXISTS publisher CASCADE
;

DROP TABLE IF EXISTS book CASCADE
;

CREATE TABLE publisher
(
	publisher_id int,
	publisher_name varchar(128) NOT NULL,
	address text,
	
	CONSTRAINT publisher_pkey PRIMARY KEY(publisher_id)	
)
;

CREATE TABLE book
(
	book_id int,
	title text,
	isbn varchar,
	publisher_id int,
	
	CONSTRAINT book_pkey PRIMARY KEY(book_id),
	CONSTRAINT book_publisher_fkey FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id) 
)
;

ALTER TABLE book
ADD COLUMN price decimal CONSTRAINT book_price_check CHECK(price > 0) 
;

CREATE TABLE customer
(
	customer_id serial,
	full_name text,
	status char DEFAULT 'r',
	
	CONSTRAINT customer_pkey PRIMARY KEY(customer_id),
	CONSTRAINT customer_status_check CHECK(status = 'r' OR status = 'p')
)
;

TRUNCATE TABLE customer RESTART IDENTITY
;

INSERT INTO customer(full_name) 
VALUES('name')
;

SELECT
	*
FROM
	customer	
;	

--Последовательность
CREATE SEQUENCE seq1
;

SELECT nextval('seq1')
;

SELECT setval('seq1', 4, false)
;


SELECT currval('seq1')
;

SELECT lastval()

CREATE SEQUENCE IF NOT EXISTS seq2 INCREMENT 5
;

ALTER SEQUENCE seq1 RENAME TO seq3
;

ALTER SEQUENCE seq1 RESTART WITH 16
;

SELECT nextval('seq2')
;

DROP SEQUENCE seq1
;

DROP SEQUENCE seq2
;

-- Использование последовательности в таблице

DROP TABLE IF EXISTS book
;

CREATE TABLE book
(
	book_id int GENERATED BY DEFAULT AS IDENTITY NOT NULL,
	title text NOT NULL,
	isbn varchar(32) NOT NULL,
	publisher_id int NOT NULL
)
;

CREATE TABLE book
(
	book_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	title text NOT NULL,
	isbn varchar(32) NOT NULL,
	publisher_id int NOT NULL
)
;

-- При использовании типа serial платформа использует следующий запрос.
CREATE SEQUENCE IF NOT EXISTS book_book_id_seq
START WITH 1 OWNED BY book.book_id
;

ALTER TABLE book
ALTER COLUMN book_id SET DEFAULT nextval('book_book_id_seq');
-- \

INSERT INTO book(title, isbn, publisher_id)
VALUES
	('title1', 'isbn1', 1),
	('title2', 'isbn2', 1)
;

INSERT INTO book
VALUES
	(3, 'title3', 'isbn3', 1)
;

TRUNCATE TABLE book RESTART IDENTITY
;

SELECT
	*
FROM
    book
;

--Вставка данных

DROP TABLE IF EXISTS author
;

CREATE TABLE author
(
	author_id int PRIMARY KEY NOT NULL,
	full_name varchar(64) NOT NULL,
	rating int 
)
;

-- Вставка данных во все колонки
INSERT INTO author
VALUES(1, 'John Silver', 3)
;

SELECT
	*
FROM
	author
;	

--Вставка данных в определенные колонки
INSERT INTO author(author_id, full_name)
VALUES
	(2, 'Tom Silver'),
	(3, 'Key Silver')
;

SELECT
	*
FROM
	author
;	

--Копирование данных таблицы с условием и создание новой
SELECT
	*
INTO
	best_authors
FROM
 	author
WHERE
    rating >= 3
;	

SELECT
	*
FROM
	best_authors
;

-- Вставка данных с использованием выборки данных
INSERT INTO best_authors
SELECT
	*
FROM
	author
WHERE 	
    rating IS NULL
RETURNING *
;

SELECT
	*
FROM
	best_authors
;

TRUNCATE best_authors
;

--Обновление данных в таблице
UPDATE 
	best_authors
SET 
	rating = 4
WHERE
	author_id = 2
RETURNING *	
;

UPDATE 
	best_authors
SET 
	rating = 5
WHERE
	rating IS NULL
;

SELECT
	*
FROM
	best_authors
;

--Удаление строк с данными с таблицы по условию
DELETE FROM best_authors
WHERE
	rating IS NULL
RETURNING *	
;

SELECT
	*
FROM
	best_authors
;

--Удаление всех строк с данными с таблицы
DELETE FROM best_authors
RETURNING *	
;

SELECT
	*
FROM
	best_authors
;

--Удаление строк с данными с таблицы, работает быстрее чем DELETE  
TRUNCATE best_authors 
;

