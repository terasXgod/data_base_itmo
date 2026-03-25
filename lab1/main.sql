CREATE TYPE IF NOT EXISTS GovernmentMode AS ENUM ('Monarchy', 'Oligarchy', 'Democracy', 'Theocracy', 'Autocracy');
CREATE DOMAIN IF NOT EXISTS positive_iq AS INT CHECK (VALUE > 0 AND VALUE < 200);
CREATE DOMAIN IF NOT EXISTS positive_square AS FLOAT CHECK (VALUE > 0 AND VALUE < 2000);
CREATE DOMAIN IF NOT EXISTS correct_date AS DATE CHECK (VALUE IS NOT NULL AND VALUE < CURRENT_DATE);

CREATE TABLE IF NOT EXISTS Desert (
    id SERIAL PRIMARY KEY,
    square positive_square,
    airHumidity FLOAT CHECK (airHumidity >= 0 AND airHumidity <= 100),
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Oasis (
    id SERIAL PRIMARY KEY,
    Desert_id INT REFERENCES Desert(id) ON DELETE CASCADE NOT NULL,
    square positive_square,
    name VARCHAR(255) NOT NULL,
    fertility FLOAT CHECK (fertility > 0)
);

CREATE TABLE IF NOT EXISTS Ruler (
    id SERIAL PRIMARY KEY,
    iq positive_iq,
    human_id INT
);

CREATE TABLE IF NOT EXISTS Civilization (
    id SERIAL PRIMARY KEY,
    Oasis_id INT REFERENCES Oasis(id) ON DELETE CASCADE NOT NULL,
    Ruler_id INT,
    lore VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    fertility FLOAT CHECK (fertility > 0),
    governmentMode GovernmentMode
);

CREATE TABLE IF NOT EXISTS Human (
    id SERIAL PRIMARY KEY,
    Civilization_id INT NOT NULL,
    weight FLOAT CHECK (weight > 0 AND weight < 300),
    dna BYTEA,
    isAlive BOOLEAN CHECK ((isAlive IS TRUE AND deathDate IS NULL) OR (isAlive IS FALSE AND deathDate IS NOT NULL)),
    birthDate correct_date,
    deathDate DATE CHECK (deathDate > birthDate)
);

CREATE TABLE IF NOT EXISTS Commander (
    id SERIAL PRIMARY KEY,
    iq positive_iq,
    human_id INT REFERENCES human(id) ON DELETE CASCADE NOT NULL
);


CREATE TABLE IF NOT EXISTS Army (
    id SERIAL PRIMARY KEY,
    Civilization_id INT REFERENCES Civilization(id),
    commander_ID INT REFERENCES Commander(id) ON DELETE CASCADE NOT NULL,
    force FLOAT CHECK (force > 0)
);

CREATE TABLE IF NOT EXISTS Wars (
    id SERIAL PRIMARY KEY,
    reason VARCHAR(255),
    exodus VARCHAR(255),
    startDate correct_date,
    endDate DATE CHECK (endDate > startDate)
);

CREATE TABLE IF NOT EXISTS WarsArmies (
    army_id INT REFERENCES Army(id) ON DELETE CASCADE NOT NULL,
    war_id INT REFERENCES Wars(id) ON DELETE CASCADE NOT NULL,
    PRIMARY KEY (army_id, war_id)
);

ALTER TABLE Human
    ADD CONSTRAINT fk_human_civ FOREIGN KEY (Civilization_id)
        REFERENCES Civilization(id);

ALTER TABLE Ruler
    ADD CONSTRAINT IF NOT EXISTS fk_ruler_human FOREIGN KEY (human_id)
        REFERENCES Human(id);

ALTER TABLE Civilization
    ADD CONSTRAINT IF NOT EXISTS fk_civ_ruler FOREIGN KEY (Ruler_id)
        REFERENCES Ruler(id);

TRUNCATE TABLE desert, oasis, ruler, army, civilization, human, commander, wars, WarsArmies RESTART IDENTITY CASCADE;