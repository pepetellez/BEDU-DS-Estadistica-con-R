# Postwork Sesión 1.

#### Objetivo

El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, de tal modo que sirvan para reafirmar el conocimiento. Recuerda que la programación es como un deporte en el que se debe practicar, habrá caídas, pero lo importante es levantarse y seguir adelante. Éxito

1. Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a `R`, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php

2. Del data frame que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

3. Consulta cómo funciona la función `table` en `R` al ejecutar en la consola `?table`
 
Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

- La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)


1.Cargamos los datos de los partidos de la liga española\
2.Seleccionamos las columnas que contienen los goles\
3.Probabilidades marginales

```R
library(dplyr)
la.liga <- read.csv("SP12019.csv")
dim(la.liga)
```


Goles hechos en por el equipo en casa
```R
goles.h <- la.liga$FTHG 
```
Goles hechos en por el equipo que fue de visita
```R
goles.a <- la.liga$FTAG
```


Probabilidades marginales de los goles hechos en casa
```R
prop.table(table(goles.h)) * 100
```
Probabilidades marginales de los goles hechos de visita
```R
prop.table(table(goles.a)) * 100
```
Probabilidad marginal conjunta de los goles hechos en casa y de visita
```R
prop.table(table(goles.h,goles.a)) * 100
```
