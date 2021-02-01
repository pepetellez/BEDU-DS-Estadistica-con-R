# Postwork Sesión 1.
#### Solución

Con la ayuda de `table` crearemos una tabla de contingencia que es una herramienta utilizada en la rama de la estadística, la cual consiste en crear al menos dos filas y dos columnas para representar datos categóricos en términos de conteos de frecuencia.

Importación de datos
```R
library(dplyr)
la.liga <- read.csv("SP12019.csv")
head(la.liga); tail(la.liga); summary(la.liga); dim(la.liga); 

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

##### Información acerca de table

Si utilizamos en la termninal`?table` encontramos la siguiente información:
###### table() returns a contingency table, an object of class "table", an array of integer values. Note that unlike S the result is always an array, a 1D array if one factor is given. 
