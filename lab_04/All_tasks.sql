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


CREATE ASSEMBLY SqlServerUDF
AUTHORIZATION dbo
FROM 'C:\Users\HYPERPC\Desktop\GraphicTry\Database4\Database4\bin\Debug\Database4.dll'
WITH PERMISSION_SET = SAFE
GO

-- ��������� �������
CREATE FUNCTION GetRandomNumber () -- ������ ������
RETURNS INT
AS
EXTERNAL NAME
SqlServerUDF.[SqlServerUDF].GetRandomNumber -- � ������� - ������������ ��� (��� � visual studio), �� ������ - ��� assembly 
GO

-- ���������� ������� (���� ���������� ��� � ���-��� �������� > @var)
CREATE AGGREGATE Count_something(@var int)
RETURNS INT
EXTERNAL NAME
SqlServerUDF.[my_aggregate]
GO

-- ��������� �������
CREATE FUNCTION talbe_function(@InputName NVARCHAR(4000))
RETURNS TABLE
(
    word_1 NVARCHAR(50),
	space_amount INT,
	word_2 NVARCHAR(50)
)
AS
EXTERNAL NAME
SqlServerUDF.[SqlServerUDF].my_table_function
GO


-- �������� ��������� (���� ������� ����� �����, ������ ������ � ���� �� ������������ @developer
CREATE PROCEDURE Avg_player_amount(@Developer_name NVARCHAR(30))
AS
EXTERNAL NAME
SqlServerUDF.[StoredProcedures].stored_proc
GO

-- ������
GO
CREATE TRIGGER update_trigger
ON PersonalInformation
INSTEAD OF UPDATE
AS
EXTERNAL NAME
SqlServerUDF.[Triggers].MyTrigger
GO



-- ����� ���
CREATE TYPE dbo.vector
EXTERNAL NAME SqlServerUDF.[vector]







--- ����� -------------------------

-- ��������� �������
SELECT dbo.GetRandomNumber() AS RandomNumber
GO


-- ���������� ������� (���-�� ���� ���� �� ��������� > 5)
SELECT dbo.Count_something(Games.TournamenstAmount) AS counted -- ������ ������
FROM Games
GO

-- ��������� �������
GO
SELECT * FROM dbo.talbe_function('Hello world d d d')
GO


-- �������� ��������� (������� ����� ������)
GO
EXEC Avg_player_amount 'Cinemax'
GO

-- �������
UPDATE PersonalInformation SET CountryId = 1
WHERE Id = 1
GO

-- ���������������� ���
CREATE TABLE dbo.Test
( 
  id INT IDENTITY(1,1) NOT NULL, 
  p vector NULL,
);
GO

-- Testing inserts
-- Correct values 
INSERT INTO dbo.Test(p) VALUES('12,15'); 
INSERT INTO dbo.Test(p) VALUES('1,0'); 
INSERT INTO dbo.Test(p) VALUES('21,8');  
GO 
-- An incorrect value 
INSERT INTO dbo.Test(p) VALUES('a,2');
GO

-- Check the data - byte stream
SELECT * FROM dbo.Test;

SELECT id, p.ToString() AS Point 
FROM dbo.Test;

GO
DECLARE @p1 dbo.vector, @p2 dbo.vector
SET @p1 = CAST('1,2' AS dbo.vector)
SET @p2 = CAST('3,4' AS dbo.vector)
SELECT @p1.Scalar_mult_vector(@p2) AS 'result'
GO

GO
DROP FUNCTION GetRandomNumber;
DROP AGGREGATE Count_something
DROP FUNCTION talbe_function;
DROP PROC Avg_player_amount;
DROP TRIGGER update_trigger;
DROP Table dbo.test;
DROP TYPE vector;
DROP ASSEMBLY SqlServerUDF;

