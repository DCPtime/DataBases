
CREATE PROCEDURE dbo.GetDegree @Number INT, @Degree INT
AS
    SET @Number = POWER(@Number, @Degree)
	RETURN @Number
GO