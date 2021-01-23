#library(dplyr)

#1.Cargamos los datos de los partidos de la liga española
```R
la.liga <- read.csv("SP12019.csv")
dim(la.liga)
```
#2.Seleccionamos las columnas que contienen los goles 

#Goles hechos en por el equipo en casa
goles.h <- la.liga$FTHG 
#Goles hechos en por el equipo que fue de visita
goles.a <- la.liga$FTAG

#3.Probabilidades marginales

#Probabilidades marginales de los goles hechos en casa
prop.table(table(goles.h)) * 100

#Probabilidades marginales de los goles hechos de visita
prop.table(table(goles.a)) * 100

#Probabilidad marginal conjunta de los goles hechos en casa y de visita
prop.table(table(goles.h,goles.a)) * 100
