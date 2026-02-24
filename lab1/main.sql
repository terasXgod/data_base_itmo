CREATE TYPE GovernmentMode AS ENUM ('Monarchy', 'Oligarchy', 'Democracy', 'Theocracy', 'Autocracy');

CREATE TABLE IF NOT EXISTS Desert (
    id SERIAL PRIMARY KEY,
    square FLOAT,
    airHumidity FLOAT,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Oasis (
    id SERIAL PRIMARY KEY,
    Desert_id INT REFERENCES Desert(id) ON DELETE CASCADE,
    square FLOAT,
    name VARCHAR(255),
    fertility FLOAT
);

CREATE TABLE IF NOT EXISTS Ruler (
    id SERIAL PRIMARY KEY,
    iq INT,
    birthDate DATE,
    deathDate DATE,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Civilization (
    id SERIAL PRIMARY KEY,
    Oasis_id INT REFERENCES Oasis(id) ON DELETE CASCADE,
    Ruler_id INT REFERENCES Ruler(id),
    lore VARCHAR(255),
    name VARCHAR(255),
    fertility FLOAT,
    governmentMode GovernmentMode
);

CREATE TABLE IF NOT EXISTS Human (
    id SERIAL PRIMARY KEY,
    Civilization_id INT REFERENCES Civilization(id),
    weight FLOAT,
    money DECIMAL,
    dna BYTEA,
    isAlive BOOLEAN,
    birthDate DATE,
    deathDate DATE
);

CREATE TABLE IF NOT EXISTS Commander (
    id SERIAL PRIMARY KEY,
    iq INT,
    birthDate DATE,
    deathDate DATE
);


CREATE TABLE IF NOT EXISTS Army (
    id SERIAL PRIMARY KEY,
    Civilization_id INT REFERENCES Civilization(id),
    commander_ID INT REFERENCES Commander(id) ON DELETE CASCADE,
    force FLOAT
);

CREATE TABLE IF NOT EXISTS Wars (
    id SERIAL PRIMARY KEY,
    reason VARCHAR(255),
    exodus VARCHAR(255),
    startDate DATE,
    endDate DATE
);

CREATE TABLE IF NOT EXISTS WarsArmies (
    army_id INT REFERENCES Army(id) ON DELETE CASCADE,
    war_id INT REFERENCES Wars(id) ON DELETE CASCADE,
    PRIMARY KEY (army_id, war_id)
);