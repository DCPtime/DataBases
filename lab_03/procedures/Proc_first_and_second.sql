USE CyberSport;
GO
-- Показать некоторую информацию о игроках, имеющих количество побед в турнирах > 3 
CREATE PROCEDURE Good_players_info AS
BEGIN -- Begin/end - просто для отделения тела процедуры от остальной части скрипта
    SELECT Players.NickName, Players.ChampionCount, Players.PrizeMoney
	FROM Players
	WHERE Players.ChampionCount > 3
END;

EXEC Good_players_info -- Вызываем эту процедуру

DROP PROCEDURE Good_players_info; -- Удаление процедуры

--23)
-- Рекурсивное обобщенное табличное выражение

CREATE TABLE Airplane (
    ContainingAssembly VARCHAR(10),
    ContainedAssembly VARCHAR(10),
    QuantityContained INT,
    UnitCost DECIMAL (6,2)
);

INSERT INTO Airplane
VALUES
( 'Самолет', 'Фюзеляж',1, 10),
( 'Самолет', 'Крылья', 1, 11),
( 'Самолет', 'Хвост',1, 12),
( 'Фюзеляж', 'Салон', 1, 13),
( 'Фюзеляж', 'Кабина', 1, 14),
( 'Фюзеляж', 'Нос',1, 15),
( 'Салон', NULL, 1,13),
( 'Кабина', NULL, 1, 14),
( 'Нос', NULL, 1, 15),
( 'Крылья', NULL,2, 11),
( 'Хвост', NULL, 1, 12)

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
SELECT assembly1 'Деталь', SUM(quantity) 'Кол-во', SUM(cost) 'Цена'
FROM list_of_parts
GROUP BY assembly1
HAVING assembly1 =  @select_parametr
GO

EXEC  select_assebmly_cost 'Кабина'

DROP PROCEDURE select_assebmly_cost; -- Удаление процедуры
DROP TABLE Airplane
