-- 1
SELECT Н_ЛЮДИ.ОТЧЕСТВО, Н_СЕССИЯ.ИД
FROM Н_ЛЮДИ INNER JOIN Н_СЕССИЯ ON Н_ЛЮДИ.ИД=Н_СЕССИЯ.ЧЛВК_ИД
WHERE Н_ЛЮДИ.ФАМИЛИЯ = 'Петров' AND Н_СЕССИЯ > '2011/2012';

-- 2
SELECT Н_ЛЮДИ.ФАМИЛИЯ, Н_ВЕДОМОСТИ.ИД, Н_СЕССИЯ.ДАТА 
FROM Н_ЛЮДИ 
LEFT JOIN Н_ВЕДОМОСТИ ON Н_ЛЮДИ.ИД = Н_ВЕДОМОСТИ.ЧЛВК_ИД
LEFT JOIN Н_СЕССИЯ ON Н_ЛЮДИ.ИД = Н_СЕССИЯ.ЧЛВК_ИД
WHERE Н_ЛЮДИ.ОТЧЕСТВО > 'Сергеевич' AND Н_ВЕДОМОСТИ.ИД > 1457443 AND Н_СЕССИЯ.ЧЛВК_ИД < 105948;

-- 3
SELECT COUNT(*), ДАТА_РОЖДЕНИЯ
FROM (
    SELECT ДАТА_РОЖДЕНИЯ
    FROM Н_ЛЮДИ
    GROUP BY ДАТА_РОЖДЕНИЯ
) t;

-- 4
SELECT ИМЯ, "КОЛ-ВО" FROM
(
    SELECT Н_ЛЮДИ.ИМЯ, COUNT(*) AS "КОЛ-ВО"
    FROM Н_УЧЕНИКИ 
    JOIN Н_ЛЮДИ ON Н_УЧЕНИКИ.ЧЛВК_ИД=Н_ЛЮДИ.ИД
    JOIN Н_ПЛАНЫ ON Н_УЧЕНИКИ.ПЛАН_ИД=Н_ПЛАНЫ.ИД
    JOIN Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ ON Н_ПЛАНЫ.НАПС_ИД = Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ.ИД
    JOIN Н_НАПР_СПЕЦ x ON Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ.НАПС_ИД = x.ИД
    AND lower(x.НАИМЕНОВАНИЕ)=lower('Информатика и вычислительная техника')
    GROUP BY Н_ЛЮДИ.ИМЯ
) t 
WHERE "КОЛ-ВО" = 50;

-- 5

-- 1 вариант 
WITH sred AS (
    SELECT date_part('year', AVG(x.age)) as СРЕДНИЙ_ВОЗРАСТ
    FROM (
        SELECT 
        CASE 
            WHEN Н_ЛЮДИ.ДАТА_СМЕРТИ IS NOT NULL THEN AGE(Н_ЛЮДИ.ДАТА_РОЖДЕНИЯ)
            ELSE AGE(Н_ЛЮДИ.ДАТА_РОЖДЕНИЯ, Н_ЛЮДИ.ДАТА_СМЕРТИ)
        END AS age
        FROM Н_УЧЕНИКИ 
        JOIN Н_ЛЮДИ ON Н_УЧЕНИКИ.ЧЛВК_ИД=Н_ЛЮДИ.ИД
        WHERE Н_УЧЕНИКИ.ГРУППА='3100'
    ) x
)

, t AS (
    SELECT y.ГРУППА, date_part('year', AVG(y.age)) AS "СРЕДНИЙ_ВОЗРАСТ"
    FROM (
        SELECT Н_УЧЕНИКИ.ГРУППА, 
        CASE 
            WHEN Н_ЛЮДИ.ДАТА_СМЕРТИ IS NOT NULL THEN AGE(Н_ЛЮДИ.ДАТА_РОЖДЕНИЯ)
            ELSE AGE(Н_ЛЮДИ.ДАТА_РОЖДЕНИЯ, Н_ЛЮДИ.ДАТА_СМЕРТИ)
        END AS age
        FROM Н_УЧЕНИКИ 
        JOIN Н_ЛЮДИ ON Н_УЧЕНИКИ.ЧЛВК_ИД=Н_ЛЮДИ.ИД
    ) y
    GROUP BY y.ГРУППА
)

SELECT t.ГРУППА, t.СРЕДНИЙ_ВОЗРАСТ
FROM t, sred
WHERE t.СРЕДНИЙ_ВОЗРАСТ > sred.СРЕДНИЙ_ВОЗРАСТ
ORDER BY t.ГРУППА;

-- 2 вариант
WITH t AS (
    SELECT y.ГРУППА, date_part('year', AVG(y.age)) AS "СРЕДНИЙ_ВОЗРАСТ"
    FROM (
        SELECT Н_УЧЕНИКИ.ГРУППА, 
        CASE 
            WHEN Н_ЛЮДИ.ДАТА_СМЕРТИ IS NOT NULL THEN AGE(Н_ЛЮДИ.ДАТА_РОЖДЕНИЯ)
            ELSE AGE(Н_ЛЮДИ.ДАТА_РОЖДЕНИЯ, Н_ЛЮДИ.ДАТА_СМЕРТИ)
        END AS age
        FROM Н_УЧЕНИКИ 
        JOIN Н_ЛЮДИ ON Н_УЧЕНИКИ.ЧЛВК_ИД=Н_ЛЮДИ.ИД
    ) y
    GROUP BY y.ГРУППА
)
, sred AS (
    SELECT t.СРЕДНИЙ_ВОЗРАСТ 
    FROM t
    WHERE t.ГРУППА='3100'
)
SELECT t.ГРУППА, t.СРЕДНИЙ_ВОЗРАСТ
FROM t, sred
WHERE t.СРЕДНИЙ_ВОЗРАСТ > sred.СРЕДНИЙ_ВОЗРАСТ
ORDER BY t.ГРУППА;

-- 6

SELECT stud.ГРУППА, stud.ИД, human.ФАМИЛИЯ, human.ИМЯ, human.ОТЧЕСТВО, stud.В_СВЯЗИ_С AS "НОМЕР_ПРИКАЗА" ,stud.СОСТОЯНИЕ
FROM Н_УЧЕНИКИ stud
LEFT JOIN Н_ЛЮДИ human ON stud.ЧЛВК_ИД=human.ИД
JOIN Н_ПЛАНЫ plan ON stud.ПЛАН_ИД=plan.ИД AND plan.КУРС=1
JOIN Н_ФОРМЫ_ОБУЧЕНИЯ form ON plan.ФО_ИД = form.ИД AND lower(form.НАИМЕНОВАНИЕ)=lower('очная')
WHERE EXISTS (
    SELECT 'ESKERE'
    FROM Н_УЧЕНИКИ x
    WHERE x.ИД = stud.ИД AND X.НАЧАЛО < DATE '2012-09-01' AND stud.В_СВЯЗИ_С IS NOT NULL
);

-- 7

-- 1 ВАРИАНТ(плохой)
SELECT s.ГРУППА, s.ИД, t.ФАМИЛИЯ, t.ИМЯ
FROM Н_УЧЕНИКИ s
JOIN Н_ЛЮДИ t ON s.ЧЛВК_ИД=t.ИД
WHERE EXISTS (
    SELECT 'MEOW'
    FROM Н_ЛЮДИ h 
    WHERE h.ФАМИЛИЯ = t.ФАМИЛИЯ AND h.ИД <> t.ИД
);

-- 2 ВАРИАТ
SELECT s.ГРУППА AS "ПЕРВАЯ ГРУППА", h.ГРУППА AS "ВТОРАЯ ГРУППА", t.ИД AS "ПЕРВЫЙ ИД", h.ИД AS "ВТОРОЙ ИД", t.ФАМИЛИЯ, t.ИМЯ AS "ПЕРВОЕ ИМЯ", h.ИМЯ AS "ВТОРОЕ ИМЯ"
FROM Н_УЧЕНИКИ s
JOIN Н_ЛЮДИ t ON s.ЧЛВК_ИД=t.ИД
JOIN (
    SELECT a.ФАМИЛИЯ, a.ИД, b.ГРУППА, a.ИМЯ
    FROM Н_УЧЕНИКИ b
    JOIN Н_ЛЮДИ a ON a.ИД=b.ИД
) h
ON h.ФАМИЛИЯ = t.ФАМИЛИЯ AND h.ИД <> t.ИД;