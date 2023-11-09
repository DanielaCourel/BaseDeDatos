--Asegurarse que el contenedor de docker se esté ejecutando
$docker run --name mongo-labs -d mongo:5

--Copiar archivo dentro del contenedor si todavía no está
$docker cp mflix/ mongo-labs:/mflix/

--Iniciar una terminal dentro del contenedor
$docker exec -it mongo-labs bash

--Dentro del contenedor ejecutar lo que sea necesario (este caso)
$mongorestore --host localhost --drop --gzip --db mflix /mflix/

--o se puede hacer en menos pasos:
--Copiar el archivo dentro del contenedor
$docker cp restaurantdb/restaurants.json mongo-labs:/restaurants/restaurants.json

--importar mongoimport
$docker exec -it mongo-labs mongoimport --host localhost:27017 --db restaurantdb --collection restaurants --drop --file /restaurants/restaurants.json
