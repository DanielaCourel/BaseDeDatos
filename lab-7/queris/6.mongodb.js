/* 6. Listar el id del teatro (theaterId), estado (“location.address.state”), ciudad (“location.address.city”), y coordenadas (“location.geo.coordinates”) de los 
teatros que se encuentran en algunos de los estados &quot;CA&quot;, &quot;NY&quot;, &quot;TX&quot; y el nombre de la ciudades comienza con una ‘F’. Listar 
ordenados por estado y ciudad. */

use("mflix")

db.theaters.findOne()

db.theaters.find(
    {
        $and: [
            { "location.address.state": { $in: ["CA", "NY", "TX"] } },
            { "location.address.city": { $regex: /^F/ } }
        ]
    },
    {
        "location.address.state": 1,
        "location.address.city": 1,
        "location.geo.coordinates": 1,
    }
).sort({ "location.address.state": 1, "location.address.city": 1}).pretty()
