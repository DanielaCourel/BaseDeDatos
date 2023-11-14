/* Título, año y cantidad de comentarios de las 10 películas con más comentarios. */

use('mflix')

db.movies.aggregate([
    {
        $lookup: {
            from: 'comments',
            localField: '_id',                  //cuando quise poner "_id.oid" se me trababala computadora
            foreignField: 'movie_id',
            as: 'comments'
        }
    },
    {
        $project: {
            _id: 0,
            title: 1,
            year: 1,
            numComments: { $size: '$comments' }
        }
    },
    {
        $sort: { numComments: -1 }
    },
    {
        $limit: 10
    }
]).pretty()