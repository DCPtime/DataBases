USE CyberSport;

--������� � �������
CREATE TABLE Players
(
   Id INT PRIMARY KEY IDENTITY(1, 1), /* ������� Id - ��������� ����,
                                        IDENTITY - �������, ������������� id �� 1 ��� ���������� ����� ����� �������������
									    ��� ��������: 1) ��������, ������� ����� � ������ ������
                                                      2) ��������, ������� ����� ����������� ��� ���������� ����� ������ � �����������
								      */
   NickName NVARCHAR(50) UNIQUE CHECK(Nickname !='') NOT NULL, -- CHECK - �������, �������� ������ �������������� ������ �������
   PrizeMoney INT NOT NULL,  -- NOT NULL - ������ ������� �� ����� ���� ������  (������ ������ != NULL)
   ChampionCount INT NOT NULL ,
   Game NVARCHAR(50) CHECK(Game !='') NOT NULL,
   PlayStyle NVARCHAR(50) CHECK(PlayStyle !='') NOT NULL,
   
   -- �����������
   CONSTRAINT CK_PrizeMoney CHECK(PrizeMoney > 0), -- CK - ���������� ��� ����� CHECK
   CONSTRAINT CK_ChampionCount CHECK(ChampionCount >= 0),

)

-- �������, ���������� ���������� � ����
CREATE TABLE Games
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	GameName NVARCHAR(50) CHECK(GameName !='') UNIQUE NOT NULL, --�� ��� ���� ���� ������ �� ������ �������, ��� ������ ���� ����������
	GameGenre NVARCHAR(50) CHECK(GameGenre !='') NOT NULL,
	Developer NVARCHAR(50) CHECK(Developer !='') NOT NULL,
	TournamenstAmount INT NOT NULL,
	PlayerAmount INT NOT NULL,

	 -- �����������
   CONSTRAINT CK_TournamenstAmount CHECK(TournamenstAmount >= 0),  -- CONSTRAINT ���� ����� ��� ����������� 
   CONSTRAINT CK_PlayerAmount CHECK(PlayerAmount >= 0)
)

-- �������, ���������� ���������� � ��������� �������
CREATE TABLE PersonalInformation
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	NickName NVARCHAR(50) UNIQUE CHECK(NickName !='') NOT NULL,
	FirstName NVARCHAR(50) CHECK(FirstName !='') NOT NULL,
	LastName NVARCHAR(50) CHECK(LastName !='') NOT NULL,
	AGE INT NOT NULL,
	CountryId  int NOT NULL,

	 -- �����������
   CONSTRAINT CK_AGE CHECK(AGE >= 18 AND  AGE <= 40)
)

-- ������� �� ��������
CREATE TABLE Countries
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	Country  NVARCHAR(50) UNIQUE CHECK(Country !='') NOT NULL,
)



ALTER TABLE Players
ADD CONSTRAINT FK_Players_GameName FOREIGN KEY(Game)  REFERENCES Games(GameName); -- ������� ���� ������ ��������� �� ���������� ������� �������, �� ������� �� ���������

ALTER TABLE Players
ADD CONSTRAINT FK_Players_NickName FOREIGN KEY(NickName) REFERENCES  PersonalInformation(NickName); 

ALTER TABLE PersonalInformation
ADD CONSTRAINT FK_PersonalInformation_CountryId FOREIGN KEY(CountryId) REFERENCES  Countries(Id); 

