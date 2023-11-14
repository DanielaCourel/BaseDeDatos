/* Listar los usuarios que realizaron comentarios durante el mismo mes de lanzamiento de la película comentada, mostrando Nombre, 
Email, fecha del comentario, título de la película, fecha de lanzamiento. HINT: usar $lookup con multiple condiciones */

use('mflix')

db.comments.aggregate([
    {
        $lookup: {
          from: "movies",
          localField: "movie_id",
          foreignField: "_id",
          let: { commentMonth: { $month: "$date" }},
          pipeline: [{
            $match: {
                "released": { $exists: true },
                $expr: { $eq: [ "$$commentMonth", {$month: "$released" } ] }
            }
          }],
          as: "movies"
        }
    },
    {
        $unwind: "$movies"
    },
    {
        $project: {
          _id: 0,
          "name": 1,
          "email": 1,
          "date": 1,
          "movies.title": 1,
          "movies.released": 1
        }
    }
])