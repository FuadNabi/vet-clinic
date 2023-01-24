SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered IS true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered IS true;

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

  UPDATE animals
  SET species = 'unspecified';

ROLLBACK;

BEGIN;

  UPDATE animals 
  SET species = 'digimon'
  WHERE name LIKE '%mon%';

  UPDATE animals
  SET species = 'pokemon'
  WHERE species is NULL;

COMMIT;

BEGIN;
  TRUNCATE TABLE animals;
ROLLBACK;

BEGIN;
  DELETE FROM animals
  WHERE date_of_birth > '2022-01-01';

  SAVEPOINT birth_date;

  UPDATE animals
  SET weight_kg = -weight_kg;

  ROLLBACK TO birth_date;

  UPDATE animals
  SET weight_kg = -weight_kg
  WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, CAST(AVG(escape_attempts) AS DECIMAL(10)) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;