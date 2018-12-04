USE CyberSport;

-- ELEMENTS - вложенный вид вместо строчек
-- ROOT - Добавили корневой элемент
-- Пареметр после RAW - название очередной строки (вместо стандартного row)


-- RAW
SELECT *
FROM Games
WHERE Games.PlayerAmount > 30400
FOR XML RAW('Game'), TYPE, ELEMENTS, ROOT ('Games')

-- AUTO
-- Записи - элементы, столбцы - атрибуты, записи на объединении - ВЛОЖЕННЫЕ элементы с атрибутами
SELECT *
FROM PersonalInformation
JOIN Countries ON PersonalInformation.Id = Countries.Id
WHERE PersonalInformation.id IN (1,2,3)
FOR XML AUTO, TYPE, ROOT ('PersonalInformation')


-- EXPLICIT (указываем сами, что у нас элемент, а что - атрибут)
SELECT 1 AS Tag, -- 1 уровень иерархии
	NULL AS Parent, -- Для верхнего уровня Parent ничего не указывается, иначе - номер родительского элемента
	Players.Id AS [Player!1!Id], -- Слева - что выбираем (атрибут), справа - как это будет выглядеть в XML файле. !1! - разделитель, перед ним - элемент.
	Players.PrizeMoney AS [Player!1!PrizeMoney!ELEMENT], -- ELEMENT - показывает, что является вложенным (будет лежать в том, что без ELEMENT)
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
FOR XML PATH('Player'), TYPE, ROOT('Players') -- После path - название элементов для каждой строки данных (Player)
                                              -- Указали корневой элемент через ROOT
											  -- с помощью @ указали, что значение Players.id должно быть атрибутом Id у элемента строки
											  -- (сделали последующие элементы вложенными)