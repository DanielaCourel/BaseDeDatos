/* Ratings de IMDB promedio, mínimo y máximo por año de las películas estrenadas en los años 80 (desde 1980 hasta 1989), ordenados 
de mayor a menor por promedio del año. */

use('mflix')

db.movies.aggregate([
    {
        $match: {
          "year": { $gte: 1980, $lte: 1989 },
          "imdb.rating": { $ne: null, $ne: "" } //tuve que agregar esta linea para no tener problemas con los campos inválidos
        }
    },
    {
        $group: {
          _id: "$year",
          promedio: { $avg: "$imdb.rating"},
          máximo: { $max: "$imdb.rating"},
          mínimo: { $min: "$imdb.rating"}
        }
    },
    {
        $sort: {
          promedio: -1
        }
    }
])