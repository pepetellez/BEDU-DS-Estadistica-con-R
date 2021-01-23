# Postwork Sesión 1.

1. Se importo los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a `R`, del siguiente enlace: https://www.football-data.co.uk/spainm.php

2. Del data frame que resulta de importar los datos a `R`, se extrajo las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

3. Se consulto cómo funciona la función `table` en `R` al ejecutar en la consola `?table`
 
Posteriormente elaboramos las tablas de frecuencias relativas para estimar las siguientes probabilidades:

- La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
- La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
- La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)\


```R
library(dplyr)
la.liga <- read.csv("SP12019.csv")
dim(la.liga)
```
Data frames
```R
#Goles hechos en por el equipo en casa
goles.h <- la.liga$FTHG 
#Goles hechos en por el equipo que fue de visita
goles.a <- la.liga$FTAG
```
Tablas de frecuencias
```R
#Probabilidades marginales de los goles hechos en casa
prop.table(table(goles.h)) * 100
#Probabilidades marginales de los goles hechos de visita
prop.table(table(goles.a)) * 100
#Probabilidad marginal conjunta de los goles hechos en casa y de visita
prop.table(table(goles.h,goles.a)) * 100
```
