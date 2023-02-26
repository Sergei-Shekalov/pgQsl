
/* 
Пример отношения один кодному и один ко многим
Отношение один кодному - если в табилице с внешним ключем только одна уникальная запись.
Отношение один ко многим - если в табилице с внешним ключем несколько записей
Отношение многие ко многим - если в табилицах с внешним ключем несколько записей.
*/

-- Создание таблиц
CREATE TABLE person
(
    person_id int PRIMARY KEY,
	first_name varchar(64) NOT NULL,
	last_name varchar(64) NOT NULL
);

CREATE TABLE passport
(
    passport_id int PRIMARY KEY,
    serial_number int NOT NULL,
	registration text NOT NULL,
	fk_passport_id int REFERENCES person(person_id)
);

CREATE TABLE diploma 
(
	diploma_id int PRIMARY KEY,
	serial_number int NOT NULL,
    fk_diploma_id int REFERENCES person(person_id)
);
	
CREATE TABLE university
(
	university_id int PRIMARY KEY,
	org_name varchar(128) NOT NULL, 
	registration text NOT NULL,
	fk_university_id int REFERENCES diploma(diploma_id)
);	

-- Создание талицы с отношением многие ко многим
CREATE TABLE person_university
(
    person_id int REFERENCES person(person_id),
	university_id int REFERENCES university(university_id),
	CONSTRAINT person_university PRIMARY KEY (person_id, university_id) -- Составной ключ  
);

-- Заполнение таблиц
INSERT INTO person
VALUES
(1, 'John', 'Snow'),
(2, 'Ned', 'Stark'),
(3, 'Rob', 'Baratheon'),
(4, 'Chloe', 'Snow'),
(5, 'Abigail', 'Baratheon');

-- Заполнение таблицы с отношением один ко дному
INSERT INTO passport
VALUES
(1, 0810665899, 'Winterfell', 1),
(2, 0810665898, 'Winterfell', 2),
(3, 0810665897, 'King''s Lading', 3)
(4, 0810678781, 'Winterfell', 4),
(5, 0810678782, 'King''s Lading', 5);

-- Заполнение таблицы с отношением один ко многим
INSERT INTO diploma
VALUES
(1, 111222333, 1),
(2, 333444555, 1),
(3, 555666777, 2);
(5, 999888777, 3),
(6, 777666555, 3)
(7, 555444333, 4),
(8, 333222111, 5);

INSERT INTO university
VALUES
(1, 'Harvard University', 'Winterfell',   1),
(2, 'Princeton University', 'Winterfell', 2),
(3, 'Yale University', 'King''s Lading',  3),
(4, 'Columbia University', 'Columbia', 4),
(5, 'University of Chicago', 'Chicago', 5),
(6, 'Massachusetts Institute of Technology', 'King''s Lading', 6);

-- Заполнение таблицы с отношением многие ко многим
INSERT INTO
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 5),
(4, 5);

