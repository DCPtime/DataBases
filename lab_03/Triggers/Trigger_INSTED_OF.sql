USE CyberSport;
GO

-- При каждом UPDATE ставим countryId = 1 вне зависимости от того, какой параметр указали в update для countryID
CREATE TRIGGER UPDATE_INFO
ON PersonalInformation
INSTEAD OF UPDATE
AS
UPDATE PersonalInformation
SET CountryId = 1
WHERE Id = (SELECT Id FROM inserted)

GO

DROP TRIGGER UPDATE_INFO -- Удаление триггера

GO

DISABLE TRIGGER  UPDATE_INFO ON  PersonalInformation  -- Отключение триггера
GO

ENABLE TRIGGER  UPDATE_INFO ON  PersonalInformation  -- Включение триггера
GO

-- Возвращаем на место
UPDATE PersonalInformation SET CountryId = 100 WHERE Id = 1

GO
DISABLE TRIGGER  UPDATE_INFO ON  PersonalInformation  -- Отключение триггера
UPDATE PersonalInformation SET CountryId = 5 WHERE Id = 1