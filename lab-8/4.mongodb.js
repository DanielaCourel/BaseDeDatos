/* Cantidad de películas estrenadas en los años 50 (desde 1950 hasta 1959). Se puede responder sin pipeline de agregación, 
realizar ambas queries. */

use('mflix')

db.movies.find(
    {
        "year": { $gte: 1950, $lte: 1959 }
    }
).count()

use('mflix')

db.movies.aggregate([
    {
        $match: {
            "year": { $gte: 1950, $lte: 1959 }
        }
    },
    {
        $count: "CoutMovies"
    }
])