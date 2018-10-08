USE CyberSport;

--1)
-- Имена столбцов могут быть одинаковыми у разных таблиц, поэтому выбираем через "."
-- DISTINCT - уникальные строки

-- Список игроков, которые играют защитным стилем и выиграли больше 1000 призовых
SELECT Players.NickName, Players.PrizeMoney, Players.PlayStyle
FROM Players
WHERE Players.PrizeMoney > 25000 AND Players.PlayStyle = '   Defensive '


--2)
-- BETWEEN - покажет строки со значением между границами

-- Выбираем игры с количеством игроков от 20000 до 23000
SELECT Games.GameName, Games.PlayerAmount
FROM Games
WHERE PlayerAmount BETWEEN 20000 AND 23000

--3)
-- LIKE %параметр% - выбирает те столбцы, где 

-- Выбираем те игры, которые содержат в названии слово 'Battlefield'
SELECT Games.GameName, Games.Developer
FROM Games
WHERE Games.GameName LIKE  '%Battlefield%' 

--4)
--IN - предложение, позволяющее заменить множественное OR в паре с WHERE (чтобы не писать: параметр = такой-то OR параметр = такой-то,
--     а просто заменить на: параметр IN (такой-то, такой-то)

-- Выбрать игроков, которые играют в игры жанра RTS и выигрывали турниры больше 2 раз
SELECT *
FROM Players
WHERE Players.Game IN
    (
        SELECT Games.GameName
		FROM Games
		WHERE Games.GameGenre = '   RTS'
    ) AND Players.ChampionCount > 2

--5)
-- EXIST используется с WHERE для проверки существования записей в подзапросе
-- SELECT во подзапросе игнорируется (может стоять хоть "1\0")

-- Выбрать игры, в которые проф.игроки не играют (из таблицы players)
SELECT *
FROM Games
WHERE NOT EXISTS
    (
           SELECT *
		   FROM Players
		   WHERE Players.Game = Games.GameName
    )


--6)

--Получить список всех игр, в которые играет больше игроков, чем в любую из игр жанра RTS
SELECT *
FROM Games
WHERE Games.PlayerAmount > ALL
    (
	    SELECT Games.PlayerAmount
		FROM Games
		WHERE Games.GameGenre = '   RTS'
    )

--7) ------------------------- C группировкой GROUP BY
--GROUP BY выводит для параметра после "GROUP BY" те значения агр.функций, которые относятся к этому параметру
-- Пример - для всех строк, имеющих определнный CountryId (!= Id элемента таблицы, в которй лежит CountryId)
-- (т.е в таблице может быть несколько строк с одним и тем же параметром CountryId) он будет счититать кол-во (Count)
-- людей и средний возвраст, т.е только для этих строк, несмотря на другие, где CountryId != тому, по которому в данный момент считаем

-- Найти количество игроков, играющих в каждой из стран и их средний возраст
SELECT PersonalInformation.CountryId, COUNT(PersonalInformation.CountryId) AS Amount_of_players, 
AVG(PersonalInformation.AGE) AS AVG_AGE
FROM PersonalInformation GROUP BY PersonalInformation.CountryId


--8)
-- Скалярная функция - такая, что возвращает одно значение
-- Здесь использует кореллирующий подзапрос таблицы (их 2), который обращается к той же таблице, что и основной
-- Первый подзапрос создает таблицу со средним кол-вом игроков у разработчика, а второй выбирает только те из
-- таблицы Developer, где этих людей > ср.арифметического playersAmount у данного разработчика

-- Вывести игры конкретного разработчика, в которых играет больше среднего арифметического людей, 
-- чем во всех играх этого разработчика
SELECT Developer, GameName,  PlayerAmount,
       (SELECT AVG(PlayerAmount) FROM Games AS SubAmount
	    WHERE SubAmount.Developer = Games_main.Developer) AS AvgAmount
FROM Games AS Games_main
WHERE PlayerAmount >
    (SELECT AVG(PlayerAmount) FROM Games As SubAmount
	 WHERE SubAmount.Developer = Games_main.Developer)

--9)
-- Простое  CASE - использует ВЫРАЖЕНИЕ (2*2 и т.д)

-- По жанру игры указать, какой в ней тип турнира
SELECT Games.GameName, Games.TournamenstAmount,
    CASE Games.GameGenre
	    WHEN '   MOBA' THEN 'Team'
		WHEN '   FPS' THEN 'Team'
		WHEN '      Sport' THEN 'Team'
		ELSE 'Single'
	END AS TournamentType
FROM Games

--10)
-- Поисковое CASE - использует УСЛОВИЕ (2>4 и т.д)

-- По количество играющих игроков указать, насколько конкретная игра популярна
SELECT Games.GameName,
    CASE
	    WHEN Games.PlayerAmount < 4000 THEN 'Unpopular'
		WHEN Games.PlayerAmount BETWEEN 4000 AND 10000 THEN 'Average'
		WHEN Games.PlayerAmount BETWEEN 10000 AND 25000 THEN 'Popular'
		ELSE 'Bestseller'
	END AS Popularity
FROM Games

--11)
-- Временная локальная таблица доступна только сессии, где она была создана, на время, равное существованию запроса
-- определяется как обычная таблица, но с "#" перед именем. Глобальные с "##", они доступны и параллельным сессиям

-- Создать временную таблицу, заполнив её полями о разработчиках и кол-во турниров, где были их (разработчиков) игры
SELECT Games.Developer, 
       SUM(Games.TournamenstAmount) AS Develop_tournaments
INTO #TempDevelopTournaments
FROM Games
GROUP BY Games.Developer

SELECT *
FROM #TempDevelopTournaments

DROP TABLE #TempDevelopTournaments --Удаление таблицы до завершения сессии


--12)
--Выбрать фамилии игроков, которые играют в среднем или агрессивном стиле

SELECT Players.PlayStyle, (SELECT PersonalInformation.LastName
   FROM PersonalInformation WHERE PersonalInformation.NickName = Players.NickName) AS 'LastName'
   FROM Players
   WHERE Players.PlayStyle IN ('   Middle ','   Agressive ')


--13)
-- Выбрать из всех игроков, который живут в Russia или China и при этом играют в агрессивном стиле
-- человека с самым большим  количеством призовых
WITH Best_players AS
(
SELECT Players.NickName, Players.ChampionCount, Players.PrizeMoney
FROM Players
WHERE  Players.NickName IN 
    (
		SELECT Players.NickName
		FROM Players
		WHERE Players.PlayStyle = '   Agressive ' AND Players.NickName IN  
		(
			SELECT PersonalInformation.NickName AS SQ
			FROM PersonalInformation
			WHERE PersonalInformation.CountryId IN

			(
				SELECT Countries.Id
				FROM Countries
				WHERE Countries.Country IN (' China', ' Russia')
			)
		)
    )
)

SELECT * 
FROM Best_players
WHERE Best_players.PrizeMoney IN
    ( SELECT MAX(Best_players.PrizeMoney)
	  from Best_players)
/*
GROUP BY Best_players.NickName, Best_players.ChampionCount, Best_players.PrizeMoney
HAVING  Best_players.PrizeMoney = MAX(Best_players.PrizeMoney)
*/


--14)
--Для каждого жанра игры получить среднее, максимальное и минимальное количество в нем игроков

SELECT Games.GameGenre, MAX(Games.PlayerAmount) AS [MAX], MIN(Games.PlayerAmount) AS [MIN], AVG(Games.PlayerAmount) AS [AVG]
FROM Games
GROUP BY Games.GameGenre

--15)
--Для каждого жанра игры получить среднее, максимальное и минимальное количество в нем игроков при условии,
--что среднее кол-во игроков в этих жанрах > среднее кол-ва игроков в любой из игр

SELECT Games.GameGenre, MAX(Games.PlayerAmount) AS [MAX], MIN(Games.PlayerAmount) AS [MIN], AVG(Games.PlayerAmount) AS [AVG]
FROM Games
GROUP BY Games.GameGenre
HAVING AVG(Games.PlayerAmount) >
(
    SELECT AVG(Games.PlayerAmount) 
	FROM Games
)

--16)

--Вставить в таблицу игры одну строку
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName', 'RTS', 'SubDeveleop', 11, 1000)

DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

--17)

-- Добавить строку, исползьуя в качестве значений атрибутов результат поздапросов
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
SELECT
Games.GameName+'6',
     (
	     SELECT Games.GameGenre
		 FROM Games
		 WHERE Games.GameName = ' Flockers 5'
	 ), Games.Developer,  Games.TournamenstAmount*3,  Games.PlayerAmount*2
FROM Games
WHERE Games.GameName = ' Binaries'

DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

--18)

-- Увеличить количетсво игрков в игре с ID = 1 (battlefied) в 5 раз
UPDATE Games
SET Games.PlayerAmount = Games.PlayerAmount*5
WHERE Games.Id = 1

UPDATE Games
SET Games.PlayerAmount = Games.PlayerAmount*0.2
WHERE Games.Id = 1

--19)

-- Поставить в ячейку количество игроков строки с ID = 1 среднее количетсво всех игроков жанра RTS

UPDATE Games
SET Games.PlayerAmount = (SELECT AVG(Games.PlayerAmount)
                          FROM GAMES
						  WHERE GameGenre = '   RTS'
						  )
WHERE Games.Id = 1


-- Возвращаем прежнее
UPDATE Games
SET Games.PlayerAmount = 14372
WHERE Games.Id = 1

--20)

-- Удалить последнюю строку строку

-- Для теста вставим строку, чтобы кол-во строк на сдаче тоже было 100
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName', 'RTS', 'SubDeveleop', 11, 1000)

DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

--21)

-- Удалить две последние строки по информации от кореллированного подзапроса

-- Для теста вставим строки, чтобы кол-во строк на сдаче тоже было 100
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName', 'RTS', 'SubDeveleop', 11, 1000)
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName1', 'RTS', 'SubDeveleop', 11, 1000)

DELETE Games
WHERE Games.Id IN
    (
	    SELECT (Games.Id)
		FROM Games
		WHERE Games.Developer = 'SubDeveleop'
    )

--22)
-- Выбраить из таблицы игры те игры жанра RTS, в которых играет больше, чем среднее арифметическое во всех остальных играх RTS
-- И одновременно по ним (играм жанра RTS) проводится больше среднего арфим. турниров. 
WITH tmp_games( tmp_amount, TMP_tourn_amount) AS
    (
        SELECT AVG(Games.PlayerAmount) AS tmp_amount,
		AVG(Games.TournamenstAmount) AS  TMP_tourn_amount
        FROM Games
        WHERE Games.GameGenre =  '   RTS'
    )

SELECT Games.GameName
FROM Games
WHERE Games.PlayerAmount > (SELECT  tmp_amount FROM  tmp_games)
      AND Games.TournamenstAmount >  (SELECT TMP_tourn_amount FROM tmp_games) AND GameGenre = '   RTS'

--23)
-- Рекурсивное обобщенное табличное выражение

CREATE TABLE Airplane (
    ContainingAssembly VARCHAR(10),
    ContainedAssembly VARCHAR(10),
    QuantityContained INT,
    UnitCost DECIMAL (6,2)
);

INSERT INTO Airplane
VALUES
( 'Самолет', 'Фюзеляж',1, 10),
( 'Самолет', 'Крылья', 1, 11),
( 'Самолет', 'Хвост',1, 12),
( 'Фюзеляж', 'Салон', 1, 13),
( 'Фюзеляж', 'Кабина', 1, 14),
( 'Фюзеляж', 'Нос',1, 15),
( 'Салон', NULL, 1,13),
( 'Кабина', NULL, 1, 14),
( 'Нос', NULL, 1, 15),
( 'Крылья', NULL,2, 11),
( 'Хвост', NULL, 1, 12)

WITH list_of_parts(assembly1, quantity, cost) AS
    (SELECT ContainingAssembly, QuantityContained, UnitCost
     FROM Airplane
     WHERE ContainedAssembly IS NULL
     UNION ALL
        SELECT a.ContainingAssembly, a.QuantityContained,
            CAST(l.quantity * l.cost AS DECIMAL(6,2))
        FROM list_of_parts l, Airplane a
        WHERE l.assembly1 = a.ContainedAssembly)
SELECT assembly1 'Деталь', SUM(quantity) 'Кол-во', SUM(cost) 'Цена'
FROM list_of_parts
GROUP BY assembly1;

DROP Table Airplane


--24)
-- Синтаксис - Агрегатная фунция(столбец) OVER (PARTITION BY столбец, по которому группируем) AS имя выходного столбца

-- Выбрать по группам разработчикав самые популярные и непопулярные игры по кол-ву игроков, а также среднее кол-во турниров
-- по их играм

SELECT Games.GameName, Games.Developer, Games.GameGenre,
MAX(Games.PlayerAmount) OVER (PARTITION BY Games.Developer) AS Develop_Popular_games,
MIN(Games.PlayerAmount) OVER (PARTITION BY Games.Developer) AS Develop_Unpopular_games,
AVG(Games.TournamenstAmount) OVER (PARTITION BY Games.Developer) AS Develop_Money_games
FROM Games


CREATE TABLE last_table
(
    Id INT,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(20),
    Points INT
);

INSERT INTO last_table
VALUES
(1, 'Petr', 'Petrovich', 10),
(2, 'Alex', 'Ivanov', 20),
(1, 'Petr', 'Petrovich', 10),
(2, 'Alex', 'Ivanov', 20),
(3, 'Ivan', 'Alexeev', 10)

-- Какие строки будут удалены
SELECT *
FROM
(
  SELECT *, rn=row_number() OVER (PARTITION BY LastName ORDER BY last_table.Id)
  FROM last_table
) x
where rn > 1; 

SELECT *
FROM last_table

delete x from (
  select *, rn=row_number() over (PARTITION BY LastName ORDER BY last_table.Id)
  from last_table
) x
where rn > 1;

DROP Table last_table