/* 9. Remover todos los comentarios realizados por el usuario cuyo email es victor_patel@fakegmail.com durante el año 1980. */

use("mflix")

db.comments.deleteMany(
    {
        "email": "victor_patel@fakegmail.com",
        "year": 1980
    }
)