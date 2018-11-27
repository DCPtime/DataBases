Use CyberSport;
GO
sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
sp_configure 'clr enabled', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'clr strict security', 0; 
RECONFIGURE;

GO
DROP FUNCTION GetRandomNumber;
DROP ASSEMBLY SqlServerUDF;

CREATE ASSEMBLY SqlServerUDF
AUTHORIZATION dbo
FROM 'C:\Users\HYPERPC\Desktop\GraphicTry\Database4\Database4\bin\Debug\Database4.dll'
WITH PERMISSION_SET = SAFE
GO

CREATE FUNCTION GetRandomNumber ()
RETURNS INT
AS
EXTERNAL NAME
SqlServerUDF.[SqlServerUDF].GetRandomNumber -- в скобках - возвращаемый тип (как в visual studio), до скобок - имя assembly 
GO

SELECT dbo.GetRandomNumber() AS RandomNumber
GO