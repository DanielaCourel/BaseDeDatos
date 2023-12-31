/* Cantidad de cines (theaters) por estado. */

use('mflix')

db.theaters.aggregate([
    {
        $group: {
            _id: "$location.address.state",
            TotalCinemas: { $sum: 1 }
        }
    }
])