# 7. В подключенном MySQL репозитории создать базу данных “Друзья человека”. 
# 8. Создать таблицы с иерархией из диаграммы в БД. 
# 9. Заполнить низкоуровневые таблицы именами(животных), командами, которые они выполняют и датами рождения. 
# 10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
# 11. Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице. 
# 12. Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам
 -- создание бд
CREATE DATABASE IF NOT EXISTS  frends_peaple;
 -- подключение бд
USE frends_peaple; 
-- создание таблиц жиvотных
CREATE TABLE IF NOT EXISTS cat
 (
`Id`	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
`Name_cat` VARCHAR(45),
`Comand` VARCHAR(45),
`Birthday` DATE
);
CREATE TABLE IF NOT EXISTS dog (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
Name_dog VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);
CREATE TABLE IF NOT EXISTS hamster (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
Name_hamster VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);
-- создание таблиц вьючных животных
CREATE TABLE IF NOT EXISTS horse (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
payload INT,
Name_horse VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);
CREATE TABLE IF NOT EXISTS camel(
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
payload INT,
Name_camel VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);
CREATE TABLE IF NOT EXISTS donkey (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
payload INT,
Name_donkey VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);
-- создание таблиц дом. животных 
CREATE TABLE IF NOT EXISTS pet (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
Name_1 VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);

CREATE TABLE IF NOT EXISTS Pack_Animal (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
Name_2 VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);

-- создание таблиц общую таблицу 
CREATE TABLE IF NOT EXISTS pet (
Id	INT NOT NULL AUTO_INCREMENT PRIMARY	KEY,
Name_all VARCHAR(45),
Comand VARCHAR(45),
Birthday DATE
);
TRUNCATE TABLE  cat;
INSERT INTO cat(Name_cat,Comand,Birthday)
VALUES
    ('Марсик1', 'Спать', '2020-01-01'),
    ('Марсик2', 'Спать', '2020-02-02'),
	('Марсик3', 'Спать', '2020-03-03'),
    ('Марсик4', 'Спать', '2020-04-04');

SELECT * FROM cat;
TRUNCATE TABLE dog;
INSERT INTO dog(Name_dog,Comand,Birthday)
VALUES
    ('Персик1', 'Лежать', '2021-01-01'),
    ('Персик2', 'Лежать', '2021-02-02'),
	('Персик3', 'Лежать', '2021-03-03'),
    ('Персик4', 'Лежать', '2021-04-04');
    
SELECT * FROM dog;

TRUNCATE TABLE hamster;
INSERT INTO hamster(Name_hamster,Comand,Birthday)
VALUES
    ('Альтрон1', 'Сидеть', '2022-01-01'),
    ('Альтрон2', 'Сидеть', '2022-02-02'),
	('Альтрон3', 'Сидеть', '2022-03-03'),
    ('Альтрон4', 'Сидеть', '2022-04-04');
    
SELECT * FROM hamster;

TRUNCATE TABLE camel;
INSERT INTO camel (payload, Name_camel, Comand, Birthday) VALUES
    (100, 'Верблюд1', 'Поднять', '2020-01-13'),
    (200, 'Верблюд2', 'Поднять', '2020-01-14'),
	(300, 'Верблюд3', 'Поднять', '2020-01-15'),
    (400, 'Верблюд4', 'Поднять', '2020-01-16');

SELECT * FROM camel;

TRUNCATE TABLE horse;
INSERT INTO horse (payload, Name_horse, Comand,  Birthday) VALUES
    (50, 'Конь1', 'Галоп', '2020-01-17'),
    (60, 'Конь2', 'Галоп', '2021-01-18'),
	(70, 'Конь3', 'Галоп', '2022-01-19'),
    (80, 'Конь4', 'Галоп', '2023-01-20');
	
SELECT * FROM horse; 

INSERT INTO donkey (payload, Name_donkey, Comand, Birthday) VALUES
    (100, 'Осел1', 'Тащить', '2020-01-22'),
    (200, 'Осел2', 'Тащить', '2021-01-23'),
	(300, 'Осел3', 'Тащить', '2022-01-24'),
    (400, 'Осел4', 'Тащить', '2023-01-25');
	
SELECT * FROM donkey; 

DROP TABLE camel;


CREATE TABLE HorseDonkey (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name_horse, 
        Comand, 
        Birthday
FROM horse UNION 
SELECT  Name_donkey, 
        Comand, 
        Birthday
FROM donkey;
SELECT * FROM HorseDonkey; 

## Создание таблицы молодых животных, в которой все животные в возрасте от 1 до 3 лет.
## В отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице.

CREATE TABLE youngAnimals (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name_horse AS 'Name' , 
        Comand, 
        Birthday,
        Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 1) AS age
FROM HorseDonkey
WHERE   Round((year(current_date()) - year(Birthday)) + (month(current_date() - month(Birthday)))/10, 1) BETWEEN 1 AND 3;
    
    ## проверяем 
SELECT * FROM youngAnimals;

## Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

CREATE TABLE finalTable (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY)
SELECT  Name_cat AS "Name", 
        Comand,
        Birthday,
        'cat' AS oldTable
FROM cat UNION 
SELECT  Name_dog, 
        Comand, 
        Birthday,
        'dog' AS oldTable
FROM dog UNION
SELECT  Name_hamster, 
        Comand, 
        Birthday,
        'hamster' AS oldTable
FROM hamster UNION 
SELECT  Name_horse, 
        Comand, 
        Birthday,
        'horse' AS oldTable
FROM horse UNION 
SELECT  Name_donkey, 
        Comand, 
        Birthday,
        'donkey' AS oldTable
FROM donkey;

    ## проверяем
    SELECT * FROM finalTable;

DELETE TABLE finalTable ;