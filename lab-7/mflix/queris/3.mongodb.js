/* 3. Listar el nombre, email, texto y fecha de los comentarios que la película con id (movie_id) ObjectId(&quot;573a1399f29313caabcee886&quot;) recibió entre los 
años 2014 y 2016 inclusive. Listar ordenados por fecha. Escribir una nueva consulta (modificando la anterior) para responder ¿Cuántos comentarios recibió? */

use('mflix')

db.comments.find(
    {
      "date": {
        $gte: ISODate("2014-01-01T00:00:00Z"),
        $lt: ISODate("2017-01-01T00:00:00Z")
      }
    },
    {
        name: 1,
        email: 1,
        text: 1,
        date: 1,
        _id: 0
    }
).sort({ "date": 1 }).count()