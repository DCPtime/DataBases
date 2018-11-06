USE CyberSport;

-- Проходим по строкам таблицы с champCount > 3, и с помощью курсора добавляем нужные даннае во временную таблицу
GO

CREATE PROCEDURE procedure_with_cursor AS
DECLARE @ID INT
DECLARE @NickName VARCHAR (50)
DECLARE @Champ_count INT

-- Создаем временную таблицу
CREATE TABLE #temp_table
(Id INT,
NickName NVARCHAR(50),
Champ_coumt INT)

-- Объявляем курсор
DECLARE @CURSOR CURSOR
-- Заполняем курсор
SET @CURSOR = CURSOR SCROLL
    FOR
    SELECT Id, NickName, ChampionCount
        FROM Players
		WHERE ChampionCount > 3
-- Открываем курсор
OPEN @CURSOR
FETCH NEXT FROM @CURSOR INTO @ID,  @NickName, @Champ_count
-- Выполнялем в цикле перебор строк
WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN
    INSERT INTO #temp_table (Id, NickName, Champ_coumt) VALUES(@ID, @NickName, @Champ_count)
    END
FETCH NEXT FROM @CURSOR INTO @ID, @NickName, @Champ_count
END
CLOSE @CURSOR
SELECT *
FROM #temp_table
DROP TABLE #temp_table

EXEC  procedure_with_cursor -- Вызываем эту процедуру


