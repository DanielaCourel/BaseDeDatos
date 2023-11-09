~~~COMANDOS~~~

~Crear una nueva colección:
db.createCollection('newCollection')

~Insertar nuevos elementos a una colección:
db.newCollection.insert({json})

~Consultar elementos:
db.newCollection.find(atributo: condición)

~Actualizar valor de un elemento:
db.newCollection.update({condición para saber cual elegir}, {$set: {atributo: newValue}})

~Eliminar elemento:
db.newCollection.deleteOne({atributo: codición})
