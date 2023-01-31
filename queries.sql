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

SELECT species FROM animals;

ROLLBACK;

SELECT species FROM animals;


BEGIN;

  UPDATE animals 
  SET species = 'digimon'
  WHERE name LIKE '%mon%';

  UPDATE animals
  SET species = 'pokemon'
  WHERE species is NULL;

  SELECT species FROM animals;

COMMIT;

  SELECT species FROM animals;


BEGIN;
  TRUNCATE TABLE animals;

  SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;


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

SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners FULL OUTER JOIN animals ON owners.id = animals.owner_id;

SELECT COUNT(animals.name), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT owners.full_name, animals.name, species.name FROM owners INNER JOIN animals ON owners.id = animals.owner_id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT owners.full_name, animals.name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;

SELECT vets.name, animals.name, visits.date_of_visit FROM vets INNER JOIN visits ON vets.id = visits.vet_id INNER JOIN animals ON visits.animal_id = animals.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT vets.name, COUNT(animals.name) FROM vets INNER JOIN visits ON vets.id = visits.vet_id INNER JOIN animals ON visits.animal_id = animals.id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

SELECT vets.name, species.name FROM vets FULL OUTER JOIN specializations ON vets.id = specializations.vet_id FULL OUTER JOIN species ON species.id = specializations.species_id;

SELECT animals.name, visits.date_of_visit 
  FROM animals 
  JOIN visits 
    ON animals.id = visits.animal_id 
  WHERE visits.vet_id = 
    (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez') 
  AND visits.date_of_visit 
    BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(*) FROM visits 
  INNER JOIN animals
    ON animals.id = visits.animal_id
  GROUP BY animals.name
  ORDER BY COUNT(*) DESC
  LIMIT 1;

SELECT animals.name AS "Animal Name" 
  FROM visits
  INNER JOIN vets
    ON visits.vet_id = vets.id
  INNER JOIN animals
    ON visits.animal_id = animals.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.date_of_visit ASC
  LIMIT 1;

SELECT *  
  FROM visits
  INNER JOIN animals
    ON visits.animal_id = animals.id
  INNER JOIN vets 
    ON visits.vet_id = vets.id
  ORDER BY visits.date_of_visit DESC
  LIMIT 1;

SELECT COUNT(*), vets.name
  FROM visits
  INNER JOIN vets
    ON visits.vet_id = vets.id
  FULL OUTER JOIN specializations
    ON vets.id = specializations.vet_id
  WHERE specializations.species_id IS NULL
  GROUP BY vets.name;

SELECT species.name, COUNT(*) 
  FROM visits
  INNER JOIN vets
    ON visits.vet_id = vets.id
  INNER JOIN animals
    ON visits.animal_id = animals.id
  INNER JOIN species
    ON species.id = animals.species_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY COUNT(*) DESC
  LIMIT 1;

SELECT COUNT(*) FROM visits where animal_id = 4;
CREATE INDEX visits_animal_id ON visits(animal_id);

SELECT * FROM visits where vet_id = 2;
CREATE INDEX visits_vet_id ON visits(vet_id);

SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX owners_email ON owners(email);

DROP INDEX visits_vet_id;

CREATE INDEX visits_vet_id ON visits(vet_id);
-- Screenshot added in pull request's description