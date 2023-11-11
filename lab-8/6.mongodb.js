/* Top 10 de usuarios con mayor cantidad de comentarios, mostrando Nombre, Email y Cantidad de Comentarios. */

use('mflix')

db.comments.aggregate([
    {
        $group: {
          _id: "$name",
          CountComments: {
            $sum: 1
          }
        }
    },
    {
        $sort: {
          "CountComments": -1
        }
    },
    {
        $limit: 10
    }
])