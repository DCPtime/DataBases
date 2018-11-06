USE CyberSport;

CREATE TABLE Airplane
(
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


GO
CREATE FUNCTION select_assebmly_cost_function(@select_parametr NVARCHAR(50))
RETURNS table
AS
RETURN
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

SELECT * from dbo.select_assebmly_cost_function('Самолет')

DROP PROCEDURE select_assebmly_cost; -- Удаление процедуры
DROP TABLE Airplane