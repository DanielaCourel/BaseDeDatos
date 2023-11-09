/* 7. Actualizar los valores de los campos texto (text) y fecha (date) del comentario cuyo id es ObjectId(&quot;5b72236520a3277c015b3b73&quot;) a &quot;mi mejor 
comentario&quot; y fecha actual respectivamente. */

use("mflix")

db.comments.update(
    {
        "_id": {$eq: ObjectId("5b72236520a3277c015b3b73") }
    },
    {
        $set: {text: "mi mejor comentario"},
        $currentDate: { date: true }
    }
)

/* Comprobación de que funcionó bien */

/* db.comments.find(
    {
        "_id": {$eq: ObjectId("5b72236520a3277c015b3b73") }
    }
) */