USE CyberSport;

--Таблица о игроках
CREATE TABLE Players
(
   Id INT PRIMARY KEY IDENTITY(1, 1), /* Столбоц Id - первичный ключ,
                                        IDENTITY - атрибут, увеличивающий id на 1 при добавлении новых строк автоматически
									    его атрибуты: 1) значение, который будет у первой строки
                                                      2) значение, которое будет прибавлятся при добавлении новой строки к предыдущему
								      */
   NickName NVARCHAR(20) UNIQUE CHECK(Nickname !='') NOT NULL, -- CHECK - условия, которому должны соотвествовать ячейки таблицы
   PrizeMoney INT NOT NULL,  -- NOT NULL - ячейка стоблца не может быть пустой  (пустая строка != NULL)
   ChampionCount INT NOT NULL ,
   Game NVARCHAR(20) CHECK(Game !='') NOT NULL,
   PlayStyle NVARCHAR(20) CHECK(PlayStyle !='') NOT NULL
)

-- Таблица, содержащая информацию о игре
CREATE TABLE Games
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	GameName NVARCHAR(20) CHECK(GameName !='') UNIQUE NOT NULL, --На это поля есть ссылка из другой таблицы, оно должно быть уникальным
	GameGenre NVARCHAR(20) CHECK(GameGenre !='') NOT NULL,
	Developer NVARCHAR(20) CHECK(Developer !='') NOT NULL,
	TournamenstAmount INT NOT NULL,
	PlayerAmount INT NOT NULL
)

-- Таблица, содержащая информацию о личностях игроков
CREATE TABLE PersonalInformation
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	NickName NVARCHAR(20) UNIQUE CHECK(NickName !='') NOT NULL,
	FirstName NVARCHAR(20) CHECK(FirstName !='') NOT NULL,
	LastName NVARCHAR(20) CHECK(LastName !='') NOT NULL,
	AGE INT NOT NULL,
	Country  NVARCHAR(20) CHECK(Country !='') NOT NULL
)



ALTER TABLE Players
ADD FOREIGN KEY(Game) REFERENCES Games(GameName); -- Внешний ключ должен указывать на УНИКАЛЬНЫЙ столбец таблицы, на которую он указывает

ALTER TABLE Players
ADD FOREIGN KEY(NickName) REFERENCES  PersonalInformation(NickName);

