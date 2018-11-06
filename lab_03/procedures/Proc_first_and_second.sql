USE CyberSport;
GO
-- �������� ��������� ���������� � �������, ������� ���������� ����� � �������� > 3 
CREATE PROCEDURE Good_players_info AS
BEGIN -- Begin/end - ������ ��� ��������� ���� ��������� �� ��������� ����� �������
    SELECT Players.NickName, Players.ChampionCount, Players.PrizeMoney
	FROM Players
	WHERE Players.ChampionCount > 3
END;

EXEC Good_players_info -- �������� ��� ���������

DROP PROCEDURE Good_players_info; -- �������� ���������

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

CREATE PROCEDURE select_assebmly_cost
@select_parametr NVARCHAR(50) AS
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
GROUP BY assembly1
HAVING assembly1 =  @select_parametr
GO

EXEC  select_assebmly_cost '������'

DROP PROCEDURE select_assebmly_cost; -- �������� ���������
DROP TABLE Airplane
