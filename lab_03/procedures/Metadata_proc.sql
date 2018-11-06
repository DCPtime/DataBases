CREATE PROCEDURE Show_some_metadata AS -- Данные о типах столбцов двух таблиц
BEGIN
SELECT TABLE_CATALOG,
       TABLE_SCHEMA,	
       TABLE_NAME,
       COLUMN_NAME,
       DATA_TYPE,
       CHARACTER_MAXIMUM_LENGTH
FROM CyberSport.INFORMATION_SCHEMA.columns
WHERE table_name = 'Players' or table_name = 'PersonalInformation'
END
GO

EXECUTE Show_some_metadata
DROP PROCEDURE Show_some_metadata; -- Удаление процедуры