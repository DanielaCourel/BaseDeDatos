/* 8. Actualizar el valor de la contraseña del usuario cuyo email es joel.macdonel@fakegmail.com a &quot;some password&quot;. La misma consulta debe poder insertar 
un nuevo usuario en caso que el usuario no exista. Ejecute la consulta dos veces. ¿Qué operación se realiza en cada caso? (Hint: usar upserts). */

use("mflix")

db.users.updateOne(
    {
        "email": "joel.macdonel@fakegmail.com"
    },
    {
        $set: {password: "some password"}
    },
    { upsert: true }
)

/* En la primer ejecusión */

/* {
    "acknowledged": true,
    "insertedId": {
      "$oid": "654acb946a03f3376efc5f18"
    },
    "matchedCount": 0,
    "modifiedCount": 0,
    "upsertedCount": 1
  } */

/* En la segunda ejecusión */

/* {
    "acknowledged": true,
    "insertedId": null,
    "matchedCount": 1,
    "modifiedCount": 0,
    "upsertedCount": 0
  } */