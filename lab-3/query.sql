--Lista el nombre de la ciudad, nombre del país, región y forma de gobierno de las 10 ciudades más pobladas del mundo
SELECT i.Name AS city, o.Name AS country, o.Region, o.GovernmentForm FROM city AS i INNER JOIN country AS o ON i.CountryCode = o.Code ORDER BY i.Population DESC LIMIT 10;

--Listar los 10 países con menor población del mundo, junto a sus ciudades capitales
SELECT o.Name AS country, i.Name city FROM country AS o INNER JOIN city AS i ON i.CountryCode = o.Code WHERE i.ID = o.Capital or o.Capital IS NULL ORDER BY o.Population ASC LIMIT 10;

--Listar el nombre, continente y todos los lenguajes oficiales de cada país.
SELECT co.Name AS Country, co.Continent, GROUP_CONCAT(cl.Language ORDER BY cl.Language SEPARATOR ', ') AS OfficialLanguages
FROM country AS co
INNER JOIN countrylanguage AS cl ON co.Code = cl.CountryCode
WHERE cl.IsOfficial = 'T'
GROUP BY co.Name, co.Continent;

--Listar el nombre del país y nombre de capital, de los 20 países con mayor superficie del mundo.
SELECT co.Name AS Country, ci.Name AS Capital
FROM country AS co
INNER JOIN city AS ci ON co.Capital = ci.ID
ORDER BY co.SurfaceArea DESC LIMIT 20;

--Listar las ciudades junto a sus idiomas oficiales (ordenado por la población de la ciudad) y el porcentaje de hablantes del idioma.
SELECT ci.Name AS City, cl.Language, cl.Percentage
FROM city AS ci
INNER JOIN countrylanguage AS cl ON cl.CountryCode = ci.CountryCode
ORDER BY ci.Population DESC;

--Listar los 10 países con mayor población y los 10 países con menor población (que tengan al menos 100 habitantes) en la misma consulta.
(SELECT Name AS Country, Population 
FROM country
ORDER BY Population DESC LIMIT 10)
UNION
(SELECT Name AS Country, Population 
FROM country
WHERE Population >= 100
ORDER BY Population ASC LIMIT 10);

--Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés
(SELECT coun.Name 
FROM country AS coun
INNER JOIN countrylanguage AS cl ON cl.CountryCode = coun.Code
WHERE cl.language = "English"
GROUP BY coun.Name)
INTERSECT
(SELECT coun.Name 
FROM country AS coun
INNER JOIN countrylanguage AS cl ON cl.CountryCode = coun.Code
WHERE cl.language =  "French"
GROUP BY coun.Name);

-- Listar aquellos países que tengan hablantes del Inglés pero no del Español en su población.
(SELECT coun.Name 
FROM country AS coun
INNER JOIN countrylanguage AS cl ON cl.CountryCode = coun.Code
WHERE cl.language = "English"
GROUP BY coun.Name)
EXCEPT
(SELECT coun.Name 
FROM country AS coun
INNER JOIN countrylanguage AS cl ON cl.CountryCode = coun.Code
WHERE cl.language =  "Spanish"
GROUP BY coun.Name);


--Ejercicio 2
SELECT city.Name, country.Name					--selecciona estos elementos
FROM city							--de esta tabla
INNER JOIN country 						--unida con esta 
ON city.CountryCode = country.Code AND country.Name = 'Argentina'; --tomando las filas que cumplan las condiciones A y B.

SELECT city.Name, country.Name					--selecciona estos elementos
FROM city							--de esta tabla
INNER JOIN country ON city.CountryCode = country.Code		--unida con esta tomando las filas que cumplan las condiciones A
WHERE country.Name = 'Argentina';				--y después se seleccionan sólo las filas que cumplan B.
--Devuelven lo mismo, ya que se seleccionan los elementos de cada tabla que cumplen con eso, entonces si se le aplica B durante el JOIN o después se sigue seleccionando sobre el grupo de la intersección de las dos tablas.



SELECT city.Name, country.Name					--selecciona estos elementos
FROM city							--de esta tabla
LEFT JOIN country 						--unida con esta 
ON city.CountryCode = country.Code AND country.Name = 'Argentina'; --tomando las filas que cumplan las condiciones A y B.

SELECT city.Name, country.Name					--selecciona estos elementos
FROM city							--de esta tabla
LEFT JOIN country ON city.CountryCode = country.Code		--unida con esta tomando las filas que cumplan las condiciones A
WHERE country.Name = 'Argentina';
--No devuelve lo mismo porque en la primer tabla devuelve todos las ciudades y agrega a la tabla las columnas de las ciudades que cumplen la condición, el resto lo deja en null.
--En cambio en la segunda tabla se toman todas las ciudades y las filas de los países que cumplen la condición, y luego se elijen sólo las columnas que cumplen una condición sobre las columnas que pertenecían a la tabla country.
