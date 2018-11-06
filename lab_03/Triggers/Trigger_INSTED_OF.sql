USE CyberSport;
GO

-- ��� ������ UPDATE ������ countryId = 1 ��� ����������� �� ����, ����� �������� ������� � update ��� countryID
CREATE TRIGGER UPDATE_INFO
ON PersonalInformation
INSTEAD OF UPDATE
AS
UPDATE PersonalInformation
SET CountryId = 1
WHERE Id = (SELECT Id FROM inserted)

GO

DROP TRIGGER UPDATE_INFO -- �������� ��������

GO

DISABLE TRIGGER  UPDATE_INFO ON  PersonalInformation  -- ���������� ��������
GO

ENABLE TRIGGER  UPDATE_INFO ON  PersonalInformation  -- ��������� ��������
GO

-- ���������� �� �����
UPDATE PersonalInformation SET CountryId = 100 WHERE Id = 1

GO
DISABLE TRIGGER  UPDATE_INFO ON  PersonalInformation  -- ���������� ��������
UPDATE PersonalInformation SET CountryId = 5 WHERE Id = 1