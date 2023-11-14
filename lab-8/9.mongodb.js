/* Crear una vista con los 5 géneros con mayor cantidad de comentarios, junto con la cantidad de comentarios. */

use('mflix')

pipeline = [
    {
        $unwind: "$genres"
    },
    {
        $lookup: {
          from: "comments",
          localField: "_id",
          foreignField: "movie_id",
          as: "cmts"
        }
    },
    {
        $project: {
          "genres": 1,
          numComments: { $size: "$cmts" }
        }
    },
    {
        $group: {
          _id: "$genres",
          numComts: { $sum: "$numComments" }
        }
    },
    {
        $sort: {
          numComts: -1
        }
    },
    {
        $limit: 5
    }
]

db.createView("MoviesWhitMoreComments", "movies", pipeline)

db.MoviesWhitMoreComments.find()