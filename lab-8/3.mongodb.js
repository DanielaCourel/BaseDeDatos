/* Cantidad de películas dirigidas por "Louis Lumière". Se puede responder sin pipeline de agregación, realizar ambas queries. */

use('mflix')

db.theaters

db.theaters.aggregate([
    {
        $match: {

        }
    }
])