USE CyberSport;
GO


-- Возвращаем среднее количество денег, заработанное на одном турнире.
CREATE FUNCTION Money_avg_per_tournament(@amount_of_money INT, @amount_of_tournaments INT)
RETURNS FLOAT
AS
BEGIN
    IF @amount_of_tournaments = 0
	    RETURN(-1)
	RETURN(@amount_of_money*1.0/@amount_of_tournaments*1.0)
END;
GO

SELECT dbo.Money_avg_per_tournament(10,0)
SELECT dbo.Money_avg_per_tournament(10,3)


DROP FUNCTION  dbo.Money_avg_per_tournament;  



DROP FUNCTION  testF; 