# Postwork Sesión 6.
Equipo 12
### Solución

#### Objetivo
* Aprender a crear una serie de tiempo en R.

#### Desarrollo
* Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
* Obtén el promedio por mes de la suma de goles.
* Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019. 
* Grafica la serie de tiempo.

#### Código
Se llaman a las librerias que se van a utilizar y se establece el directorio de trabajo
```R
library(dplyr)
library(xts)
setwd("C:/Users/EduHdzVillasana/Documents/GitHub/BEDU-DS-Estadistica-con-R/Postwork Sesion 6/Postwork Files")
```
Se agrega la nueva columna
```R
data <- read.csv("match.data.csv")
head(data)
dim(data)
sumagoles <- data$home.score + data$away.score
data <- cbind(data, sumagoles)
```
Fragmento del dataframe resultante.

![PCTABLA](https://github.com/CristopherCano/BEDU-DS-Estadistica-con-R/blob/master/Postwork%20Sesion%206/Imagenes/1.png)

Se obtiene el prómedio por mes de la suma de goles
```R
data <- mutate(data, date = as.Date(date, "%Y-%m-%d"))
data <- mutate(data, date = format(date,"%Y-%m"))
newData <- select(data, date, sumagoles)
gNewData <- newData %>% group_by(date) %>% summarise(meangoles = mean(sumagoles))
```
Fragmento del datafreame resultante.

![PCTABLA](https://github.com/CristopherCano/BEDU-DS-Estadistica-con-R/blob/master/Postwork%20Sesion%206/Imagenes/2.png)

Se crea y se grafica la serie de tiempo
```R
data.ts <- ts(gNewData$meangoles, st = c(2010, 8), end = c(2019, 12), fr = 12)
plot(data.ts)
```
Imagen de la serie de tiempo.

![PCTABLA](https://github.com/CristopherCano/BEDU-DS-Estadistica-con-R/blob/master/Postwork%20Sesion%206/Imagenes/3.png)

#### Conclusión
En este postwork aprendimos como se crea una serie de tiempo y cuando aplicarla, como vemos en la imagen, no se ve una tendencia fija en el promedio de goles mensuales, tal parece que es totalmente aleatorio.
