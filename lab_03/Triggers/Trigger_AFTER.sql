USE CyberSport;
GO

-- ��� ���������� � ���������� ��������� ���-�� ������� �� 0.3 �� ���������� ����������
CREATE TRIGGER Players_amount_INSERT_UPDATE
ON Games
AFTER INSERT, UPDATE
AS
UPDATE Games
SET Games.PlayerAmount = PlayerAmount - PlayerAmount * 0.3
WHERE Id = (SELECT Id FROM inserted) -- ������� inserted ��������� ������������� ��� ���������� ��� ��������� ������, ������ ����� Id
GO

DROP TRIGGER Players_amount_INSERT_UPDATE -- �������� ��������

GO

DISABLE TRIGGER Players_amount_INSERT_UPDATE ON Games  -- ���������� ��������
GO

ENABLE TRIGGER  Players_amount_INSERT_UPDATE ON Games  -- ��������� ��������
GO

--�����
-- ��� ����������
UPDATE Games SET PlayerAmount = 10 WHERE GameName = ' Battlefield'

-- ��� ����������
INSERT INTO Games(GameName, GameGenre, Developer, TournamenstAmount, PlayerAmount)
VALUES(' Battlefield0', '   RTS', '   Developer', 12, 15001)

-- ������� ��������� ����������� ������ ��� ���������� ��������������� ���� �������
DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

-- ���������� ������� ��������, �������� �������
GO
DISABLE TRIGGER Players_amount_INSERT_UPDATE ON Games  -- ���������� ��������
UPDATE Games SET PlayerAmount = 14372 WHERE GameName = ' Battlefield'

