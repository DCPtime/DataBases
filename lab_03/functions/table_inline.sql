USE CyberSport;
GO


-- INLINE вариант таблицы с играми от разработчика, указанного в параметре
CREATE FUNCTION table_inline_function(@check NVARCHAR(50))
RETURNS  table
AS
RETURN
   SELECT Games.Id, Games.GameName, Games.Developer, Games.GameGenre
   FROM Games
   WHERE Games.Developer = @check
GO

SELECT * from dbo. table_inline_function('   Cinemax')
SELECT * from dbo. table_inline_function('')


DROP FUNCTION  dbo.table_inline_function;  
