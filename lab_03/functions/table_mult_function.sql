USE CyberSport;
GO


-- Многооператорный вариант таблицы с играми от разработчика, указанного в параметре
CREATE FUNCTION table_mult_function(@check NVARCHAR(50))
RETURNS @result table (Id INT, Game_name NVARCHAR(50), Developer NVARCHAR(50),  GameGenre NVARCHAR(50) )
AS
BEGIN
   INSERT @result
   SELECT Games.Id, Games.GameName, Games.Developer, Games.GameGenre
   FROM Games WHERE Games.Developer = @check
   RETURN
END;
GO

SELECT * from dbo.table_mult_function('   Cinemax')
SELECT * from dbo.table_mult_function('')


DROP FUNCTION  dbo.table_mult_function;  
