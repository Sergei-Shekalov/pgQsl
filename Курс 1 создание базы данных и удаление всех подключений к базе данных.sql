--Используеться для удаления подключений к базе данных.
--При запущенных сеансах нельзя удалить базу данных.  
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'testdb'
AND pid <> pg_backend_pid();

DROP DATABASE testdb; --Удаление таблицы

CREATE DATABASE testdb; --Создание таблицы



