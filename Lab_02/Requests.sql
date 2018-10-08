USE CyberSport;

--1)
-- ����� �������� ����� ���� ����������� � ������ ������, ������� �������� ����� "."
-- DISTINCT - ���������� ������

-- ������ �������, ������� ������ �������� ������ � �������� ������ 1000 ��������
SELECT Players.NickName, Players.PrizeMoney, Players.PlayStyle
FROM Players
WHERE Players.PrizeMoney > 25000 AND Players.PlayStyle = '   Defensive '


--2)
-- BETWEEN - ������� ������ �� ��������� ����� ���������

-- �������� ���� � ����������� ������� �� 20000 �� 23000
SELECT Games.GameName, Games.PlayerAmount
FROM Games
WHERE PlayerAmount BETWEEN 20000 AND 23000

--3)
-- LIKE %��������% - �������� �� �������, ��� 

-- �������� �� ����, ������� �������� � �������� ����� 'Battlefield'
SELECT Games.GameName, Games.Developer
FROM Games
WHERE Games.GameName LIKE  '%Battlefield%' 

--4)
--IN - �����������, ����������� �������� ������������� OR � ���� � WHERE (����� �� ������: �������� = �����-�� OR �������� = �����-��,
--     � ������ �������� ��: �������� IN (�����-��, �����-��)

-- ������� �������, ������� ������ � ���� ����� RTS � ���������� ������� ������ 2 ���
SELECT *
FROM Players
WHERE Players.Game IN
    (
        SELECT Games.GameName
		FROM Games
		WHERE Games.GameGenre = '   RTS'
    ) AND Players.ChampionCount > 2

--5)
-- EXIST ������������ � WHERE ��� �������� ������������� ������� � ����������
-- SELECT �� ���������� ������������ (����� ������ ���� "1\0")

-- ������� ����, � ������� ����.������ �� ������ (�� ������� players)
SELECT *
FROM Games
WHERE NOT EXISTS
    (
           SELECT *
		   FROM Players
		   WHERE Players.Game = Games.GameName
    )


--6)

--�������� ������ ���� ���, � ������� ������ ������ �������, ��� � ����� �� ��� ����� RTS
SELECT *
FROM Games
WHERE Games.PlayerAmount > ALL
    (
	    SELECT Games.PlayerAmount
		FROM Games
		WHERE Games.GameGenre = '   RTS'
    )

--7) ------------------------- C ������������ GROUP BY
--GROUP BY ������� ��� ��������� ����� "GROUP BY" �� �������� ���.�������, ������� ��������� � ����� ���������
-- ������ - ��� ���� �����, ������� ����������� CountryId (!= Id �������� �������, � ������ ����� CountryId)
-- (�.� � ������� ����� ���� ��������� ����� � ����� � ��� �� ���������� CountryId) �� ����� ��������� ���-�� (Count)
-- ����� � ������� ��������, �.� ������ ��� ���� �����, �������� �� ������, ��� CountryId != ����, �� �������� � ������ ������ �������

-- ����� ���������� �������, �������� � ������ �� ����� � �� ������� �������
SELECT PersonalInformation.CountryId, COUNT(PersonalInformation.CountryId) AS Amount_of_players, 
AVG(PersonalInformation.AGE) AS AVG_AGE
FROM PersonalInformation GROUP BY PersonalInformation.CountryId


--8)
-- ��������� ������� - �����, ��� ���������� ���� ��������
-- ����� ���������� ������������� ��������� ������� (�� 2), ������� ���������� � ��� �� �������, ��� � ��������
-- ������ ��������� ������� ������� �� ������� ���-��� ������� � ������������, � ������ �������� ������ �� ��
-- ������� Developer, ��� ���� ����� > ��.��������������� playersAmount � ������� ������������

-- ������� ���� ����������� ������������, � ������� ������ ������ �������� ��������������� �����, 
-- ��� �� ���� ����� ����� ������������
SELECT Developer, GameName,  PlayerAmount,
       (SELECT AVG(PlayerAmount) FROM Games AS SubAmount
	    WHERE SubAmount.Developer = Games_main.Developer) AS AvgAmount
FROM Games AS Games_main
WHERE PlayerAmount >
    (SELECT AVG(PlayerAmount) FROM Games As SubAmount
	 WHERE SubAmount.Developer = Games_main.Developer)

--9)
-- �������  CASE - ���������� ��������� (2*2 � �.�)

-- �� ����� ���� �������, ����� � ��� ��� �������
SELECT Games.GameName, Games.TournamenstAmount,
    CASE Games.GameGenre
	    WHEN '   MOBA' THEN 'Team'
		WHEN '   FPS' THEN 'Team'
		WHEN '      Sport' THEN 'Team'
		ELSE 'Single'
	END AS TournamentType
FROM Games

--10)
-- ��������� CASE - ���������� ������� (2>4 � �.�)

-- �� ���������� �������� ������� �������, ��������� ���������� ���� ���������
SELECT Games.GameName,
    CASE
	    WHEN Games.PlayerAmount < 4000 THEN 'Unpopular'
		WHEN Games.PlayerAmount BETWEEN 4000 AND 10000 THEN 'Average'
		WHEN Games.PlayerAmount BETWEEN 10000 AND 25000 THEN 'Popular'
		ELSE 'Bestseller'
	END AS Popularity
FROM Games

--11)
-- ��������� ��������� ������� �������� ������ ������, ��� ��� ���� �������, �� �����, ������ ������������� �������
-- ������������ ��� ������� �������, �� � "#" ����� ������. ���������� � "##", ��� �������� � ������������ �������

-- ������� ��������� �������, �������� � ������ � ������������� � ���-�� ��������, ��� ���� �� (�������������) ����
SELECT Games.Developer, 
       SUM(Games.TournamenstAmount) AS Develop_tournaments
INTO #TempDevelopTournaments
FROM Games
GROUP BY Games.Developer

SELECT *
FROM #TempDevelopTournaments

DROP TABLE #TempDevelopTournaments --�������� ������� �� ���������� ������


--12)
--������� ������� �������, ������� ������ � ������� ��� ����������� �����

SELECT Players.PlayStyle, (SELECT PersonalInformation.LastName
   FROM PersonalInformation WHERE PersonalInformation.NickName = Players.NickName) AS 'LastName'
   FROM Players
   WHERE Players.PlayStyle IN ('   Middle ','   Agressive ')


--13)
-- ������� �� ���� �������, ������� ����� � Russia ��� China � ��� ���� ������ � ����������� �����
-- �������� � ����� �������  ����������� ��������
WITH Best_players AS
(
SELECT Players.NickName, Players.ChampionCount, Players.PrizeMoney
FROM Players
WHERE  Players.NickName IN 
    (
		SELECT Players.NickName
		FROM Players
		WHERE Players.PlayStyle = '   Agressive ' AND Players.NickName IN  
		(
			SELECT PersonalInformation.NickName AS SQ
			FROM PersonalInformation
			WHERE PersonalInformation.CountryId IN

			(
				SELECT Countries.Id
				FROM Countries
				WHERE Countries.Country IN (' China', ' Russia')
			)
		)
    )
)

SELECT * 
FROM Best_players
WHERE Best_players.PrizeMoney IN
    ( SELECT MAX(Best_players.PrizeMoney)
	  from Best_players)
/*
GROUP BY Best_players.NickName, Best_players.ChampionCount, Best_players.PrizeMoney
HAVING  Best_players.PrizeMoney = MAX(Best_players.PrizeMoney)
*/


--14)
--��� ������� ����� ���� �������� �������, ������������ � ����������� ���������� � ��� �������

SELECT Games.GameGenre, MAX(Games.PlayerAmount) AS [MAX], MIN(Games.PlayerAmount) AS [MIN], AVG(Games.PlayerAmount) AS [AVG]
FROM Games
GROUP BY Games.GameGenre

--15)
--��� ������� ����� ���� �������� �������, ������������ � ����������� ���������� � ��� ������� ��� �������,
--��� ������� ���-�� ������� � ���� ������ > ������� ���-�� ������� � ����� �� ���

SELECT Games.GameGenre, MAX(Games.PlayerAmount) AS [MAX], MIN(Games.PlayerAmount) AS [MIN], AVG(Games.PlayerAmount) AS [AVG]
FROM Games
GROUP BY Games.GameGenre
HAVING AVG(Games.PlayerAmount) >
(
    SELECT AVG(Games.PlayerAmount) 
	FROM Games
)

--16)

--�������� � ������� ���� ���� ������
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName', 'RTS', 'SubDeveleop', 11, 1000)

DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

--17)

-- �������� ������, ��������� � �������� �������� ��������� ��������� �����������
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
SELECT
Games.GameName+'6',
     (
	     SELECT Games.GameGenre
		 FROM Games
		 WHERE Games.GameName = ' Flockers 5'
	 ), Games.Developer,  Games.TournamenstAmount*3,  Games.PlayerAmount*2
FROM Games
WHERE Games.GameName = ' Binaries'

DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

--18)

-- ��������� ���������� ������ � ���� � ID = 1 (battlefied) � 5 ���
UPDATE Games
SET Games.PlayerAmount = Games.PlayerAmount*5
WHERE Games.Id = 1

UPDATE Games
SET Games.PlayerAmount = Games.PlayerAmount*0.2
WHERE Games.Id = 1

--19)

-- ��������� � ������ ���������� ������� ������ � ID = 1 ������� ���������� ���� ������� ����� RTS

UPDATE Games
SET Games.PlayerAmount = (SELECT AVG(Games.PlayerAmount)
                          FROM GAMES
						  WHERE GameGenre = '   RTS'
						  )
WHERE Games.Id = 1


-- ���������� �������
UPDATE Games
SET Games.PlayerAmount = 14372
WHERE Games.Id = 1

--20)

-- ������� ��������� ������ ������

-- ��� ����� ������� ������, ����� ���-�� ����� �� ����� ���� ���� 100
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName', 'RTS', 'SubDeveleop', 11, 1000)

DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

--21)

-- ������� ��� ��������� ������ �� ���������� �� ���������������� ����������

-- ��� ����� ������� ������, ����� ���-�� ����� �� ����� ���� ���� 100
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName', 'RTS', 'SubDeveleop', 11, 1000)
INSERT Games(Games.GameName, Games.GameGenre, Games.Developer, Games.TournamenstAmount, Games.PlayerAmount)
VALUES ('GameName1', 'RTS', 'SubDeveleop', 11, 1000)

DELETE Games
WHERE Games.Id IN
    (
	    SELECT (Games.Id)
		FROM Games
		WHERE Games.Developer = 'SubDeveleop'
    )

--22)
-- �������� �� ������� ���� �� ���� ����� RTS, � ������� ������ ������, ��� ������� �������������� �� ���� ��������� ����� RTS
-- � ������������ �� ��� (����� ����� RTS) ���������� ������ �������� �����. ��������. 
WITH tmp_games( tmp_amount, TMP_tourn_amount) AS
    (
        SELECT AVG(Games.PlayerAmount) AS tmp_amount,
		AVG(Games.TournamenstAmount) AS  TMP_tourn_amount
        FROM Games
        WHERE Games.GameGenre =  '   RTS'
    )

SELECT Games.GameName
FROM Games
WHERE Games.PlayerAmount > (SELECT  tmp_amount FROM  tmp_games)
      AND Games.TournamenstAmount >  (SELECT TMP_tourn_amount FROM tmp_games) AND GameGenre = '   RTS'

--23)
-- ����������� ���������� ��������� ���������

CREATE TABLE Airplane (
    ContainingAssembly VARCHAR(10),
    ContainedAssembly VARCHAR(10),
    QuantityContained INT,
    UnitCost DECIMAL (6,2)
);

INSERT INTO Airplane
VALUES
( '�������', '�������',1, 10),
( '�������', '������', 1, 11),
( '�������', '�����',1, 12),
( '�������', '�����', 1, 13),
( '�������', '������', 1, 14),
( '�������', '���',1, 15),
( '�����', NULL, 1,13),
( '������', NULL, 1, 14),
( '���', NULL, 1, 15),
( '������', NULL,2, 11),
( '�����', NULL, 1, 12)

WITH list_of_parts(assembly1, quantity, cost) AS
    (SELECT ContainingAssembly, QuantityContained, UnitCost
     FROM Airplane
     WHERE ContainedAssembly IS NULL
     UNION ALL
        SELECT a.ContainingAssembly, a.QuantityContained,
            CAST(l.quantity * l.cost AS DECIMAL(6,2))
        FROM list_of_parts l, Airplane a
        WHERE l.assembly1 = a.ContainedAssembly)
SELECT assembly1 '������', SUM(quantity) '���-��', SUM(cost) '����'
FROM list_of_parts
GROUP BY assembly1;

DROP Table Airplane


--24)
-- ��������� - ���������� ������(�������) OVER (PARTITION BY �������, �� �������� ����������) AS ��� ��������� �������

-- ������� �� ������� ������������� ����� ���������� � ������������ ���� �� ���-�� �������, � ����� ������� ���-�� ��������
-- �� �� �����

SELECT Games.GameName, Games.Developer, Games.GameGenre,
MAX(Games.PlayerAmount) OVER (PARTITION BY Games.Developer) AS Develop_Popular_games,
MIN(Games.PlayerAmount) OVER (PARTITION BY Games.Developer) AS Develop_Unpopular_games,
AVG(Games.TournamenstAmount) OVER (PARTITION BY Games.Developer) AS Develop_Money_games
FROM Games


CREATE TABLE last_table
(
    Id INT,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(20),
    Points INT
);

INSERT INTO last_table
VALUES
(1, 'Petr', 'Petrovich', 10),
(2, 'Alex', 'Ivanov', 20),
(1, 'Petr', 'Petrovich', 10),
(2, 'Alex', 'Ivanov', 20),
(3, 'Ivan', 'Alexeev', 10)

-- ����� ������ ����� �������
SELECT *
FROM
(
  SELECT *, rn=row_number() OVER (PARTITION BY LastName ORDER BY last_table.Id)
  FROM last_table
) x
where rn > 1; 

SELECT *
FROM last_table

delete x from (
  select *, rn=row_number() over (PARTITION BY LastName ORDER BY last_table.Id)
  from last_table
) x
where rn > 1;

DROP Table last_table