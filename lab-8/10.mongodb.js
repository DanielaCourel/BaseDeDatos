/* Listar los actores (cast) que trabajaron en 2 o más películas dirigidas por "Jules Bass". Devolver el nombre de estos actores junto
con la lista de películas (solo título y año) dirigidas por “Jules Bass” en las que trabajaron. 
Hint1: addToSet
Hint2: {'name.2': {$exists: true}} permite filtrar arrays con al menos 2 elementos, entender por qué.
Hint3: Puede que tu solución no use Hint1 ni Hint2 e igualmente sea correcta */

use('mflix')

db.movies.aggregate([
    {
        $unwind: "$cast"
    },
    {
        $unwind: "$directors"
    },
    {
        $group: {
          _id: "$cast",
          movies: { 
            $addToSet: {
                $cond: {
                    if: { $eq: ["$directors", "Jules Bass"] },
                    then: { title: "$title", year: "$year" },
                    else: "$$REMOVE"
                } 
            }
          }
        }
    },
    {
        $match: {
          'movies.2': { $exists: true }
        }
    }
])