# Postwork Sesión 7.

#### Objetivo 

- Realizar el alojamiento del fichero de un fichero `.csv` a una base de datos (BDD), en un local host de Mongodb a traves de `R`

#### Solución

Alojar el fichero  `data.csv` en una base de datos llamada `match_games`, nombrando al `collection` como `match`
```R
#Crear BDD 'match_games', nombrando a la coleccion 'match'
m.games = mongo(collection = "match", db = "match_games")

#Alojar fichero
m.games$insert(data)
```

Una vez hecho esto, realizar un `count` para conocer el número de registros que se tiene en la base
```R
#Realizar un count para conocer el numero de registros
m.games$count()
```

Realiza una consulta utilizando la sintaxis de **Mongodb**, en la base de datos para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?
```R
#Goles que metio el R.M. el 20/12/15, contra quien, y el resultado
m.games$find('{"HomeTeam": "Real Madrid", "Date": "2015-12-20"}')
```

Por último, no olvides cerrar la conexión con la BDD
```R
#Cerrar conexion BDD
rm(m.games)
```
