# Postwork Sesión 1.

Importación de datos
```R
library(dplyr)
la.liga <- read.csv("SP12019.csv")
dim(la.liga)
```
Selección de las variables
```R
#Goles hechos en por el equipo en casa
goles.h <- la.liga$FTHG 
#Goles hechos en por el equipo que fue de visita
goles.a <- la.liga$FTAG
```
Tablas de frecuencias maraginales y conjuntas
```R
#Probabilidades marginales de los goles hechos en casa
prop.table(table(goles.h)) * 100
```
![PMarginales_H](https://user-images.githubusercontent.com/71915068/105952605-6a6e1880-6037-11eb-8978-7bbb3157137d.PNG)

```R
#Probabilidades marginales de los goles hechos de visita
prop.table(table(goles.a)) * 100
```
![PMarginales_A](https://user-images.githubusercontent.com/71915068/105952618-6cd07280-6037-11eb-96b0-e4f451e9b27d.PNG)

```R
#Probabilidad marginal conjunta de los goles hechos en casa y de visita
prop.table(table(goles.h,goles.a)) * 100
```
![PConuntas](https://user-images.githubusercontent.com/71915068/105952211-e156e180-6036-11eb-8375-68039b72772c.PNG)
