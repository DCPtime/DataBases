-- Загружаем таблицу "игры"
BULK INSERT CyberSport.dbo.Games
from   'D:\GitHub\DataBases\Lab_01\BD_Table_Generator\BD_generator\games_info.txt'
with
(
ROWTERMINATOR = '\n',
fieldterminator=','
)

-- Загружаем таблицу "Страны"
BULK INSERT CyberSport.dbo.Countries
from   'D:\GitHub\DataBases\Lab_01\BD_Table_Generator\BD_generator\contires_info.txt'
with
(
ROWTERMINATOR = '\n',
fieldterminator=','
)

-- Загружаем таблицу "Персональная информация"
BULK INSERT CyberSport.dbo.PersonalInformation
from   'D:\GitHub\DataBases\Lab_01\BD_Table_Generator\BD_generator\personal_info.txt'
with
(
ROWTERMINATOR = '\n',
fieldterminator=','
)

-- Загружаем таблицу "Игроки"
BULK INSERT CyberSport.dbo.Players
from   'D:\GitHub\DataBases\Lab_01\BD_Table_Generator\BD_generator\players_info.txt'
with
(
ROWTERMINATOR = '\n',
fieldterminator=','
)

