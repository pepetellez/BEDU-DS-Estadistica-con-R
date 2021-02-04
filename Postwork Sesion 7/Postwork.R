#Cargar libreria MongoDB
library (mongolite)

#Cargar csv
data = read.csv("data.csv")

#Crear BDD 'match_games', nombrando a la coleccion 'match'
m.games = mongo(collection = "match", db = "match_games")

#Alojar fichero
m.games$insert(data)

#Realizar un count para conocer el numero de regustros
m.games$count()

#Goles que metio el R.M. el 20/12/15, contra quien, y el resultado
m.games$find('{"HomeTeam": "Real Madrid", "Date": "2015-12-20"}')

#Agregar dataset 'mtcars' a la misma BDD
m.games = mongo(collection = "mtcars", db = "match_games")
m.games$insert(mtcars)

#Cerrar conexion BDD
rm(m.games)

