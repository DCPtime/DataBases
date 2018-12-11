USE CyberSport;

CREATE TABLE weekdays_talbe
(
    person_name NVARCHAR(25), 
    week_date DATE
);
GO

INSERT INTO weekdays_talbe VALUES('person_1','2018-01-17')

INSERT INTO weekdays_talbe VALUES('person_2','2018-01-15')
INSERT INTO weekdays_talbe VALUES('person_1','2018-06-30')
INSERT INTO weekdays_talbe VALUES('person_1','2018-06-29')
INSERT INTO weekdays_talbe VALUES('person_2','2018-01-16')


SELECT * FROM  weekdays_talbe

SELECT [name], [from], MIN([to]) AS [to]
FROM
(
        SELECT A.person_name AS [name], A.week_date AS [from], C.week_date AS [to]
        FROM  weekdays_talbe A,  weekdays_talbe C
        WHERE NOT EXISTS 
        (
            SELECT * 
            FROM  weekdays_talbe B 
            WHERE (DATEDIFF(DAYOFYEAR, A.week_date, B.week_date) = -1 OR DATEDIFF(DAYOFYEAR, C.week_date, B.week_date) = 1) AND A.person_name = B.person_name
        ) AND A.week_date <= C.week_date
) AS tmp2
GROUP BY [name], [from] 

DELETE FROM weekdays_talbe

DROP TABLE weekdays_talbe;
GO
    