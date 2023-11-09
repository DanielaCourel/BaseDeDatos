/* 5. Listar el título, idiomas (languages), géneros, fecha de lanzamiento (released) y número de votos (“imdb.votes”) de las películas de géneros Drama y Action 
(la película puede tener otros géneros adicionales), que solo están disponibles en un único idioma y por último tengan un rating (“imdb.rating”) mayor a 9 o bien
tengan una duración (runtime) de al menos 180 minutos. Listar ordenados por fecha de lanzamiento y número de votos. */

//sólo falta el tema de los idiomas porque no existía ese parámetro en la colección movies

use('mflix')    

db.movies.findOne()

db.movies.find(
    {
        $and: [
            {"genres": { $in: ["Drama"] }},
            {"genres": { $in: ["Action"] }}
        ],
        $or: [
            {"imdb.rating": { $gt: 9 }},
            {"runtime": { $gte: 180 }}
        ],
    },
    {
        title: 1,
        genres: 1,
        year: 1,
        "imdb.votes": 1,
        _id: 0
    }
).sort({ "year": 1, "imdb.votes": 1 })