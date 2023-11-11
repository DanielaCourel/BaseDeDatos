/* Listar los 10 géneros con mayor cantidad de películas (tener en cuenta que las películas pueden tener más de un género). Devolver 
el género y la cantidad de películas. Hint: unwind puede ser de utilidad */

use('mflix')

db.movies.aggregate([
    {
        $unwind: "$genres"
    },
    {
        $group: {
          _id: "$genres",
          countMovies: {
            $sum: 1
          }
        }
    },
    {
        $sort: {
          "countMovies": -1
        }
    },
    {
        $limit: 10
    }
])