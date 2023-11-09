--Lista de nombre y las regiones a las que pertenece cada país ordenada alfabeticamente
SELECT Name, Region FROM country ORDER BY Name ASC;

--Lista de nombre y población de las 10 ciudades más pobladas del mundo
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 10;

--Lista de nombre, región, superficie y forma de gobierno de los 10 países con menor superficie.
SELECT Name, Region, SurfaceArea, GovernmentForm FROM country ORDER BY SurfaceArea ASC LIMIT 10;

--Lista de paises que no tienen independencia
SELECT Name FROM country WHERE IndepYear IS null;

--Lista de los países y el porcentaje total de hablantes que tienen todos los idiomas declarados como oficiales.
SELECT cl.CountryCode, SUM(cl.Percentage) AS TotalPercentage FROM countrylanguage cl WHERE cl.IsOfficial = 'T' GROUP BY cl.CountryCode HAVING COUNT(DISTINCT cl.Language) = (     SELECT COUNT(DISTINCT cl2.Language)     FROM countrylanguage cl2     WHERE cl2.IsOfficial = 'T'     AND cl2.CountryCode = cl.CountryCode );

--Actualizar valor...
UPDATE countrylanguage SET Percentage = 100.0 WHERE CountryCode = 'AIA';

