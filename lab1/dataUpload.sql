---

INSERT INTO desert (square, airHumidity, name) VALUES (123.123, 15.12, 'Sahara');
INSERT INTO desert (square, airHumidity, name) VALUES (1130.91, 52.52, 'Amazon');
INSERT INTO desert (square, airHumidity, name) VALUES (74.1, 99.13, 'Wild-berries');
INSERT INTO desert (square, airHumidity, name) VALUES (1.123, 100.0, 'Ozon');

---

INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (1, 100.0, 'Mr. Breeze', 123.1);
INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (1, 72.1, 'Ivan Gold', 1337.52);
INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (2, 1.5, 'zoom meetings', 12.2);
INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (3, 12.32, 'Dota 3', 1441.12);
INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (4, 123.0, '4k 60 fps', 12312.1);
INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (4, 1020.0, 'slowed + reverb by SLAWIK2013', 12312.1);
INSERT INTO oasis (Desert_id, square, name, fertility) VALUES (4, 110.0, 'Homo socialization', 12.1231);

---

--TRUNCATE TABLE ruler RESTART IDENTITY CASCADE;

INSERT INTO ruler (iq) VALUES (123);
INSERT INTO ruler (iq) VALUES (12);
INSERT INTO ruler (iq) VALUES (113);
INSERT INTO ruler (iq) VALUES (122);
INSERT INTO ruler (iq) VALUES (155);

---

INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (1, 1, 'born in fire', 'eskere', 52.1, 'Monarchy');
INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (2, 2, 'ancient lore', 'Atlantis', 75.0, 'Autocracy');
INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (3, 3, 'mythic tales', 'El Dorado', 60.5, 'Theocracy');
INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (4, 4, 'lost histories', 'Shangri-La', 80.2, 'Monarchy');
INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (5, 5, 'forgotten gods', 'Utopia', 90.0, 'Democracy');
INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (6, 1, 'sacred texts', 'Valhalla', 65.3, 'Oligarchy');
INSERT INTO civilization (oasis_id, ruler_id, lore, name, fertility, governmentMode) 
VALUES (7, 2, 'tales of war', 'Sparta', 55.5, 'Democracy');

---

INSERT INTO human (civilization_id, weight,  dna, isAlive, birthDate) 
VALUES (1, 56.1, '\\x48656C6C6F', TRUE, '2021-03-12');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate, deathDate) 
VALUES (2, 75.0, '\xDEADBEEF', FALSE, '1990-01-01', '2020-06-30');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate) 
VALUES (3, 60.5, '\xCAFEBABE', TRUE, '2000-12-15');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate, deathDate) 
VALUES (4, 82.3, '\x00FF00', FALSE, '1975-07-07', '2025-01-01');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate) 
VALUES (5, 48.2, '\x123456', TRUE, '2010-03-03');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate, deathDate) 
VALUES (6, 90.0, '\xABCDEF', FALSE, '1950-05-05', '2000-05-05');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate) 
VALUES (7, 68.4, '\xBEEF', TRUE, '1995-11-11');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate, deathDate) 
VALUES (1, 120.0, '\xFACE', FALSE, '1930-01-01', '1980-12-31');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate) 
VALUES (2, 55.5, '\xC0FFEE', TRUE, '2005-09-09');
INSERT INTO human (civilization_id, weight, dna, isAlive, birthDate, deathDate) 
VALUES (3, 77.7, '\xBADA55', FALSE, '1988-08-08', '2018-08-08');

UPDATE ruler SET human_id = 1 WHERE id = 1;
UPDATE ruler SET human_id = 2 WHERE id = 2;
UPDATE ruler SET human_id = 3 WHERE id = 3;
UPDATE ruler SET human_id = 4 WHERE id = 4;
UPDATE ruler SET human_id = 5 WHERE id = 5;
---

INSERT INTO commander (iq, human_id) VALUES (123, 1);
INSERT INTO commander (iq, human_id) VALUES (145, 2);
INSERT INTO commander (iq, human_id) VALUES (160, 3);
INSERT INTO commander (iq, human_id) VALUES (110, 4);
INSERT INTO commander (iq, human_id) VALUES (130, 5);
INSERT INTO commander (iq, human_id) VALUES (140, 6);
INSERT INTO commander (iq, human_id) VALUES (155, 7);
INSERT INTO commander (iq, human_id) VALUES (120, 8);
INSERT INTO commander (iq, human_id) VALUES (170, 9);
INSERT INTO commander (iq, human_id) VALUES (135, 10);

---

INSERT INTO army (civilization_id, commander_id, force) VALUES (1, 4, 100.12);
INSERT INTO army (civilization_id, commander_id, force) VALUES (2, 1, 250.5);
INSERT INTO army (civilization_id, commander_id, force) VALUES (3, 2, 75.75);
INSERT INTO army (civilization_id, commander_id, force) VALUES (4, 3, 180.0);
INSERT INTO army (civilization_id, commander_id, force) VALUES (5, 5, 90.9);
INSERT INTO army (civilization_id, commander_id, force) VALUES (6, 6, 300.3);
INSERT INTO army (civilization_id, commander_id, force) VALUES (7, 7, 45.45);
INSERT INTO army (civilization_id, commander_id, force) VALUES (1, 8, 120.12);

---

INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('bad breakfast', 'nuclear bomb dropped', '1933-02-02', '1933-02-03');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('water shortage', 'mass migration', '1940-05-05', '1940-05-20');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('territorial dispute', 'refugees', '1950-01-01', '1951-01-01');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('resource theft', 'slave trade', '1960-07-07', '1960-08-07');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('religious conflict', 'diaspora', '1970-09-09', '1971-09-09');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('economic collapse', 'urban flight', '1980-03-03', '1980-04-03');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('political coup', 'elite exodus', '1990-11-11', '1990-12-11');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('invasion', 'border crossing', '2000-06-06', '2000-07-06');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('civil unrest', 'internal displacement', '2010-10-10', '2011-10-10');
INSERT INTO Wars (reason, exodus, startDate, endDate) VALUES ('technological sabotage', 'digital refugees', '2020-12-12', '2021-12-12');

---

INSERT INTO WarsArmies (army_id, war_id) VALUES (1, 1);
INSERT INTO WarsArmies (army_id, war_id) VALUES (2, 1);
INSERT INTO WarsArmies (army_id, war_id) VALUES (3, 1);
INSERT INTO WarsArmies (army_id, war_id) VALUES (2, 2);
INSERT INTO WarsArmies (army_id, war_id) VALUES (4, 2);
INSERT INTO WarsArmies (army_id, war_id) VALUES (5, 3);
INSERT INTO WarsArmies (army_id, war_id) VALUES (7, 4);
INSERT INTO WarsArmies (army_id, war_id) VALUES (8, 5);
INSERT INTO WarsArmies (army_id, war_id) VALUES (1, 6);
INSERT INTO WarsArmies (army_id, war_id) VALUES (3, 7);
INSERT INTO WarsArmies (army_id, war_id) VALUES (5, 8);
INSERT INTO WarsArmies (army_id, war_id) VALUES (7, 9);
INSERT INTO WarsArmies (army_id, war_id) VALUES (2, 10);
INSERT INTO WarsArmies (army_id, war_id) VALUES (4, 5);
INSERT INTO WarsArmies (army_id, war_id) VALUES (6, 6);
INSERT INTO WarsArmies (army_id, war_id) VALUES (8, 7);
INSERT INTO WarsArmies (army_id, war_id) VALUES (1, 8);
INSERT INTO WarsArmies (army_id, war_id) VALUES (2, 9);
INSERT INTO WarsArmies (army_id, war_id) VALUES (3, 10);
INSERT INTO WarsArmies (army_id, war_id) VALUES (4, 1);
INSERT INTO WarsArmies (army_id, war_id) VALUES (5, 2);
INSERT INTO WarsArmies (army_id, war_id) VALUES (6, 3);
