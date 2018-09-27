USE CyberSport;

--Таблица о игроках
CREATE TABLE Players
(
   Id INT PRIMARY KEY IDENTITY(1, 1), /* Столбоц Id - первичный ключ,
                                        IDENTITY - атрибут, увеличивающий id на 1 при добавлении новых строк автоматически
									    его атрибуты: 1) значение, который будет у первой строки
                                                      2) значение, которое будет прибавлятся при добавлении новой строки к предыдущему
								      */
   NickName NVARCHAR(50) UNIQUE CHECK(Nickname !='') NOT NULL, -- CHECK - условия, которому должны соотвествовать ячейки таблицы
   PrizeMoney INT NOT NULL,  -- NOT NULL - ячейка стоблца не может быть пустой  (пустая строка != NULL)
   ChampionCount INT NOT NULL ,
   Game NVARCHAR(50) CHECK(Game !='') NOT NULL,
   PlayStyle NVARCHAR(50) CHECK(PlayStyle !='') NOT NULL,
   
   -- Ограничения
   CONSTRAINT CK_PrizeMoney CHECK(PrizeMoney > 0), -- CK - сокращение для слова CHECK
   CONSTRAINT CK_ChampionCount CHECK(ChampionCount >= 0),

)

-- Таблица, содержащая информацию о игре
CREATE TABLE Games
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	GameName NVARCHAR(50) CHECK(GameName !='') UNIQUE NOT NULL, --На это поля есть ссылка из другой таблицы, оно должно быть уникальным
	GameGenre NVARCHAR(50) CHECK(GameGenre !='') NOT NULL,
	Developer NVARCHAR(50) CHECK(Developer !='') NOT NULL,
	TournamenstAmount INT NOT NULL,
	PlayerAmount INT NOT NULL,

	 -- Ограничения
   CONSTRAINT CK_TournamenstAmount CHECK(TournamenstAmount >= 0),  -- CONSTRAINT лишь задаёт имя ограничению 
   CONSTRAINT CK_PlayerAmount CHECK(PlayerAmount >= 0)
)

-- Таблица, содержащая информацию о личностях игроков
CREATE TABLE PersonalInformation
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	NickName NVARCHAR(50) UNIQUE CHECK(NickName !='') NOT NULL,
	FirstName NVARCHAR(50) CHECK(FirstName !='') NOT NULL,
	LastName NVARCHAR(50) CHECK(LastName !='') NOT NULL,
	AGE INT NOT NULL,
	CountryId  int NOT NULL,

	 -- Ограничения
   CONSTRAINT CK_AGE CHECK(AGE >= 18 AND  AGE <= 40)
)

-- Таблица со странами
CREATE TABLE Countries
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	Country  NVARCHAR(50) UNIQUE CHECK(Country !='') NOT NULL,
)



ALTER TABLE Players
ADD CONSTRAINT FK_Players_GameName FOREIGN KEY(Game)  REFERENCES Games(GameName); -- Внешний ключ должен указывать на УНИКАЛЬНЫЙ столбец таблицы, на которую он указывает

ALTER TABLE Players
ADD CONSTRAINT FK_Players_NickName FOREIGN KEY(NickName) REFERENCES  PersonalInformation(NickName); 

ALTER TABLE PersonalInformation
ADD CONSTRAINT FK_PersonalInformation_CountryId FOREIGN KEY(CountryId) REFERENCES  Countries(Id); 

