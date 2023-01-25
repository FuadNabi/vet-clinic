CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals
    ADD COLUMN species VARCHAR(200);

CREATE TABLE owners (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY (id)
);

ALTER TABLE animals
    ADD PRIMARY KEY(id);

ALTER TABLE animals
    DROP COLUMN species;

ALTER TABLE animals
    ADD COLUMN species_id INT,
    ADD COLUMN owner_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fkey_species
    FOREIGN KEY (species_id)
    REFERENCES species(id);

ALTER TABLE animals
    ADD CONSTRAINT fkey_owner
    FOREIGN KEY (owner_id)
    REFERENCES owners(id);