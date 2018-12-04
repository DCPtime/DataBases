USE CyberSport;

-- ELEMENTS - ��������� ��� ������ �������
-- ROOT - �������� �������� �������
-- �������� ����� RAW - �������� ��������� ������ (������ ������������ row)


-- RAW
SELECT *
FROM Games
WHERE Games.PlayerAmount > 30400
FOR XML RAW('Game'), TYPE, ELEMENTS, ROOT ('Games')

-- AUTO
-- ������ - ��������, ������� - ��������, ������ �� ����������� - ��������� �������� � ����������
SELECT *
FROM PersonalInformation
JOIN Countries ON PersonalInformation.Id = Countries.Id
WHERE PersonalInformation.id IN (1,2,3)
FOR XML AUTO, TYPE, ROOT ('PersonalInformation')


-- EXPLICIT (��������� ����, ��� � ��� �������, � ��� - �������)
SELECT 1 AS Tag, -- 1 ������� ��������
	NULL AS Parent, -- ��� �������� ������ Parent ������ �� �����������, ����� - ����� ������������� ��������
	Players.Id AS [Player!1!Id], -- ����� - ��� �������� (�������), ������ - ��� ��� ����� ��������� � XML �����. !1! - �����������, ����� ��� - �������.
	Players.PrizeMoney AS [Player!1!PrizeMoney!ELEMENT], -- ELEMENT - ����������, ��� �������� ��������� (����� ������ � ���, ��� ��� ELEMENT)
	Players.PlayStyle AS [Player!1!PlaySTYLE!ELEMENT]
	FROM Players
	WHERE Players.Id > 10 and Players.id < 15
FOR XML EXPLICIT, TYPE, ROOT('Players')


-- PATH

SELECT Players.Id AS "@Id",
       Players.PrizeMoney,
	   Players.PlayStyle
FROM Players
WHERE Players.Id > 10 and Players.id < 15
FOR XML PATH('Player'), TYPE, ROOT('Players') -- ����� path - �������� ��������� ��� ������ ������ ������ (Player)
                                              -- ������� �������� ������� ����� ROOT
											  -- � ������� @ �������, ��� �������� Players.id ������ ���� ��������� Id � �������� ������
											  -- (������� ����������� �������� ����������)