#library(dplyr)

1.Cargamos los datos de los partidos de la liga española
2.Seleccionamos las columnas que contienen los goles 
3.Probabilidades marginales

```R
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
