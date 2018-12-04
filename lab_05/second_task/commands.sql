--download
DECLARE @idoc int
DECLARE @doc xml
SELECT @doc = c FROM OPENROWSET(BULK 'D:\GitHub\DataBases\lab_05\second_task\new_games.xml', 
                                SINGLE_BLOB) AS TEMP(c)
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc

SELECT *
FROM OPENXML (@idoc, '/Games/Games')
WITH (Id INT,
	GameName NVARCHAR(50), 
	GameGenre NVARCHAR(50),
	Developer NVARCHAR(50),
	TournamenstAmount INT ,
	PlayerAmount INT)
EXEC sp_xml_removedocument @idoc