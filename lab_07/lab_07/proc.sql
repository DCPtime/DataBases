USE CyberSport;
GO

CREATE PROCEDURE dbo.GetSumm @A INT output, @B INT output
AS
    SET @A = @A*@A - @B*@B
	RETURN @A
GO

DROP PROC GetSumm;