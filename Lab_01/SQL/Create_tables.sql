USE CyberSport;

--������� � �������
CREATE TABLE Players
(
   Id INT PRIMARY KEY IDENTITY(1, 1), /* ������� Id - ��������� ����,
                                        IDENTITY - �������, ������������� id �� 1 ��� ���������� ����� ����� �������������
									    ��� ��������: 1) ��������, ������� ����� � ������ ������
                                                      2) ��������, ������� ����� ����������� ��� ���������� ����� ������ � �����������
								      */
   NickName NVARCHAR(20) UNIQUE CHECK(Nickname !='') NOT NULL, -- CHECK - �������, �������� ������ �������������� ������ �������
   PrizeMoney INT NOT NULL,  -- NOT NULL - ������ ������� �� ����� ���� ������  (������ ������ != NULL)
   ChampionCount INT NOT NULL ,
   Game NVARCHAR(20) CHECK(Game !='') NOT NULL,
   PlayStyle NVARCHAR(20) CHECK(PlayStyle !='') NOT NULL,
   
   -- �����������
   CONSTRAINT CK_PrizeMoney CHECK(PrizeMoney > 0), -- CK - ���������� ��� ����� CHECK
   CONSTRAINT CK_ChampionCount CHECK(ChampionCount >= 0),

)

-- �������, ���������� ���������� � ����
CREATE TABLE Games
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
	GameName NVARCHAR(20) CHECK(GameName !='') UNIQUE NOT NULL, --�� ��� ���� ���� ������ �� ������ �������, ��� ������ ���� ����������
	GameGenre NVARCHAR(20) CHECK(GameGenre !='') NOT NULL,
	Developer NVARCHAR(20) CHECK(Developer !='') NOT NULL,
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
	NickName NVARCHAR(20) UNIQUE CHECK(NickName !='') NOT NULL,
	FirstName NVARCHAR(20) CHECK(FirstName !='') NOT NULL,
	LastName NVARCHAR(20) CHECK(LastName !='') NOT NULL,
	AGE INT NOT NULL,
	Country  NVARCHAR(20) CHECK(Country !='') NOT NULL,

	 -- �����������
   CONSTRAINT CK_AGE CHECK(AGE >= 18 AND  AGE <= 40)
)



ALTER TABLE Players
ADD CONSTRAINT FK_Players_GameName FOREIGN KEY(Game)  REFERENCES Games(GameName); -- ������� ���� ������ ��������� �� ���������� ������� �������, �� ������� �� ���������

ALTER TABLE Players
ADD CONSTRAINT FK_Players_NickName FOREIGN KEY(NickName) REFERENCES  PersonalInformation(NickName); 

