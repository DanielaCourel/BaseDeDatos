/* Cantidad de estados con al menos dos cines (theaters) registrados. */

use('mflix')

db.theaters.aggregate([
    {
        $group: {
            _id: "$location.address.state",
            TotalCinemas: { $sum: 1 }
        }
    },
    {
        $match: {
            $expr: { $gte: [ "$TotalCinemas", 2] }
        }
    },
    {
        $count: "passing_scores"
    }
])