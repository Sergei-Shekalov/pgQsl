
/*
1.Создать таблицу teacher с определенными полями.
2.В таблицу teacher добавить колонку middle_name.
3.В таблице teacher удалить колонку middle_name.
4.В таблице teacher переименуем колонку brithday на brith_day.
5.В таблице teacher для поля phone установить длину 32 символа.
6.Создать таблицу exam с определенными полями.
7.Заполнить таблицу exam данными.
8.Очистить данные в таблице exam.
*/

--1
CREATE TABLE teacher
(
	teacher_id serial,
	first_name varchar,
	last_name varchar,
	brithday date,
	phone varchar,
	title varchar  	
)
;

--2
ALTER TABLE teacher
ADD COLUMN middle_name varchar
;

--3
ALTER TABLE teacher
DROP COLUMN middle_name
;

--4
ALTER TABLE teacher
RENAME brithday TO brith_day
;

--5
ALTER TABLE teacher
ALTER COLUMN phone SET DATA TYPE varchar(32)
;

--6
CREATE TABLE exam
(
	exam_id serial,
	exam_name varchar(256),
	exam_date date
)
;

--7
INSERT INTO exam(exam_name, exam_date) 
VALUES 
	('exam 1', '2023-01-01'),
	('exam 2', '2023-01-02'),
	('exam 3', '2023-01-03'),
	('exam 4', '2023-01-04')
;

SELECT
	*
FROM
	exam
;	

--8
TRUNCATE TABLE exam RESTART IDENTITY
;
