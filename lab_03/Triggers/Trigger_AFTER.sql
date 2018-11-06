USE CyberSport;
GO

-- При добавлении и обновлении уменьшаем кол-во игроков на 0.3 от начального количества
CREATE TRIGGER Players_amount_INSERT_UPDATE
ON Games
AFTER INSERT, UPDATE
AS
UPDATE Games
SET Games.PlayerAmount = PlayerAmount - PlayerAmount * 0.3
WHERE Id = (SELECT Id FROM inserted) -- Таблица inserted создается автоматически при добавлении или изменении данных, отсюда берем Id
GO

DROP TRIGGER Players_amount_INSERT_UPDATE -- Удаление триггера

GO

DISABLE TRIGGER Players_amount_INSERT_UPDATE ON Games  -- Отключение триггера
GO

ENABLE TRIGGER  Players_amount_INSERT_UPDATE ON Games  -- Включение триггера
GO

--Тесты
-- Для обновления
UPDATE Games SET PlayerAmount = 10 WHERE GameName = ' Battlefield'

-- Для добавления
INSERT INTO Games(GameName, GameGenre, Developer, TournamenstAmount, PlayerAmount)
VALUES(' Battlefield0', '   RTS', '   Developer', 12, 15001)

-- Очищаем последнюю добавленную строку для сохранения первоначального вида таблицы
DELETE Games
WHERE Games.Id =
    (
	    SELECT MAX(Games.Id)
		FROM Games
    )

-- Возвращаем прошлое значение, отключив триггер
GO
DISABLE TRIGGER Players_amount_INSERT_UPDATE ON Games  -- Отключение триггера
UPDATE Games SET PlayerAmount = 14372 WHERE GameName = ' Battlefield'

