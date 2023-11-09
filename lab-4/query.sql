-- Listar el nombre de la ciudad y el nombre del país de todas las ciudades que pertenezcan a países con una población menor a 10000 habitantes.
SELECT ci.Name AS City, coun.Name AS Country
FROM city AS ci INNER JOIN country AS coun
ON ci.CountryCode = coun.Code
WHERE coun.Population < 10000;

--Listar todas aquellas ciudades cuya población sea mayor que la población promedio entre todas las ciudades.
SELECT Name AS City, Population
FROM city
WHERE Population > (SELECT AVG(Population) FROM city);

--Listar todas aquellas ciudades no asiáticas cuya población sea igual o mayor a la población total de algún país de Asia.
SELECT ci.Name AS City
FROM city AS ci 
INNER JOIN country AS coun ON coun.Code = ci.CountryCode and NOT coun.Continent = "Asia"
WHERE ci.Population >= (SELECT MIN(Population) FROM country WHERE Continent = "Asia");

--Listar aquellos países junto a sus idiomas no oficiales, que superen en porcentaje de hablantes a cada uno de los idiomas oficiales del país.
SELECT coun.Name, GROUP_CONCAT(cl.Language ORDER BY cl.Language SEPARATOR ', ') AS NoOfficialLanguages
FROM country AS coun
INNER JOIN countrylanguage AS cl ON cl.CountryCode = coun.Code
LEFT JOIN (SELECT clof.CountryCode AS ConCode, max(clof.Percentage) AS MaxOfficial
FROM countrylanguage AS clof
WHERE clof.IsOfficial = 'T'
GROUP BY clof.CountryCode) AS offi
ON cl.CountryCode = offi.ConCode
WHERE cl.Percentage > IFNULL(offi.MaxOfficial, 0) and cl.IsOfficial = 'F'
GROUP BY coun.Code;

--Listar (sin duplicados) aquellas regiones que tengan países con una superficie menor a 1000 km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes.
SELECT coun.Region
FROM country AS coun
INNER JOIN city AS ci ON ci.CountryCode = coun.Code
WHERE ci.Population > 100000
GROUP BY Region
EXCEPT
SELECT Region
FROM country 
WHERE SurfaceArea >= 1000
GROUP BY Region;

--Listar el nombre de cada país con la cantidad de habitantes de su ciudad más poblada. (Hint: Hay dos maneras de llegar al mismo resultado. Usando consultas escalares o usando agrupaciones, encontrar ambas).
--Resolución con agrupaciones
SELECT coun.Name AS Country, max(ci.Population) AS Population_of_City
FROM country AS coun
INNER JOIN city AS ci ON ci.CountryCode = coun.Code
GROUP BY coun.Code;
--Resulción con consultas escalares
SELECT coun.Name AS Country, (SELECT ci.Population 
FROM city AS ci 
WHERE ci.CountryCode = coun.Code 
ORDER BY Population DESC LIMIT 1) AS Population_of_City 
FROM country AS coun;

--Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes sea mayor al promedio de hablantes de los lenguajes oficiales.
SELECT coun.Name, GROUP_CONCAT(cl.Language ORDER BY cl.Language SEPARATOR ', ') AS NoOfficialLanguages
FROM country AS coun
INNER JOIN countrylanguage AS cl ON cl.CountryCode = coun.Code
LEFT JOIN (SELECT clof.CountryCode AS ConCode, avg(clof.Percentage) AS AvgOfficial
FROM countrylanguage AS clof
WHERE clof.IsOfficial = 'T'
GROUP BY clof.CountryCode) AS offi
ON cl.CountryCode = offi.ConCode
WHERE cl.Percentage > IFNULL(offi.AvgOfficial, 0) and cl.IsOfficial = 'F'
GROUP BY coun.Code;

--Listar la cantidad de habitantes por continente ordenado en forma descendente.
SELECT Continent, SUM(Population)
FROM country
GROUP BY Continent;

--Listar el promedio de esperanza de vida (LifeExpectancy) por continente con una esperanza de vida entre 40 y 70 años.
SELECT Continent, AVG(LifeExpectancy) AS AverageLifeExpectancy
FROM country
GROUP BY Continent
HAVING AverageLifeExpectancy > 40 and AverageLifeExpectancy < 70;

--Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.
SELECT Continent, MAX(Population), MIN(Population), AVG(Population), SUM(Population)
FROM country
GROUP BY Continent;


--Si en la consulta 6 se quisiera devolver, además de las columnas ya solicitadas, el nombre de la ciudad más poblada. ¿Podría lograrse con agrupaciones? ¿y con una subquery escalar?

--Resolución con agrupaciones(No funciona, el problema principal es que habría que hacer unión o join con otra tabla porque siempre que se agrupe se necesita agruparlo en base a x o aplicar una función de agrupación a esa columna, en el caso del nombre de la ciudad no tiene sentido ninguna de esas dos cosas).
SELECT coun.Name AS Country, city.CityName, city.Population_of_City
FROM country AS coun
INNER JOIN 
(SELECT ci.CountryCode, ci.Name AS CityName, MAX(ci.Population) AS Population_of_City 
FROM city AS ci 
GROUP BY ci.CountryCode) AS city 
ON city.CountryCode = coun.Code;

--Resulción con consultas escalares
SELECT c.Name AS Country,
(SELECT ci.Name FROM city AS ci WHERE ci.CountryCode = c.Code
    ORDER BY ci.Population DESC LIMIT 1 ) AS City,
(SELECT ci.Population FROM city AS ci WHERE ci.CountryCode = c.Code
    ORDER BY ci.Population DESC LIMIT 1 ) AS Population_of_City
FROM
  country AS c;



