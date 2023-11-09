/* 10. Listar el id del restaurante (restaurant_id) y las calificaciones de los restaurantes donde al menos una de sus calificaciones 
haya sido realizada entre 2014 y 2015 inclusive, y que tenga una puntuación (score) mayor a 70 y menor o igual a 90. */

use("restaurantdb")

db.restaurants.find(
    {
        "grades": {
        $elemMatch: {
            "date": {
                $gte: ISODate("2014-01-01T00:00:00Z"),
                $lt: ISODate("2016-01-01T00:00:00Z")
            },
            "score": { $gt: 70, $lte: 90 }
        }
        }
    },
    {
        restaurant_id: 1,
        grades: 1
    }
)

db.restaurants.find(
    {
        $and: [
            { 
                "grades.date": { 
                $gte: ISODate("2014-01-01T00:00:00Z"),
                $lt: ISODate("2016-01-01T00:00:00Z")
                }
            },
            {
                "grades.score": {
                    $gt: 70,
                    $lte: 90
                }
            }
        ]
    },
    {
        _id: 0,
        restaurant_id: 1,
        grades: 1
    }
)

/* $elemMatch: Este operador se utiliza para buscar documentos que contienen al menos un elemento en el arreglo grades que cumple con 
las condiciones proporcionadas.  */