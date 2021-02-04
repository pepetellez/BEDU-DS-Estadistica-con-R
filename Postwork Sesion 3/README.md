# Postwork Sesión 3

#### Objetivo

- Realizar descarga de archivos desde internet
- Generar nuevos data frames
- Visualizar probabilidades estimadas con la ayuda de gráficas

#### Solución

Código Postwork sesión 2 que genera el nuevo `data.frame`
```R
#Cargar libreria
library(dplyr)
library(ggplot2)
library(reshape2)

#Importar datos
data17 <- read.csv("SP117.csv")
data18 <- read.csv("SP118.csv")
data19 <- read.csv("SP119.csv")

#Caracteristicas de frame (str, head, View y summary)
str(data17); str(data18); str(data19)
head(data17); head(data18); head(data19)
View(data17); View(data18); View(data19)
summary(data17); summary(data18); summary(data19)

#Seleccionar columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR
listas <- list(data17, data18, data19)
listas.filtradas <- lapply(listas, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

#Convertir chr a fechas
listas.filtradas[[1]]$Date <- as.Date(listas.filtradas[[1]]$Date, "%d/%m/%y")
listas.filtradas[[2]]$Date <- as.Date(listas.filtradas[[2]]$Date, "%d/%m/%y")
listas.filtradas[[3]]$Date <- as.Date(listas.filtradas[[3]]$Date, "%d/%m/%y")

#Unir listas
lista.final <- do.call(rbind, listas.filtradas)

str(lista.final)
head(lista.final)
View(lista.final)
summary(lista.final)
```

La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
```R
#Probabilidad marginal
tabla1 <- prop.table(table(lista.final$FTHG)) * 100

#Tabla a data.frame
tabla1 <- as.data.frame(tabla1)

#Gráfica
p <- ggplot(tabla1, aes(x = Var1 , y = Freq)) + 
  geom_bar (stat="identity", fill = 'blue') +
  xlab("Goles") +
  ggtitle('Equipo de casa')
p
```
![2d0507fe-ee1d-4b27-8a41-ff50ece3b280](https://user-images.githubusercontent.com/72113099/106952900-5beac580-66f7-11eb-9225-36bb4c4f2684.png)

La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
```R
#Probabilidad marginal
tabla2 <- prop.table(table(lista.final$FTAG)) * 100

#Tabla a data.frame
tabla2 <- as.data.frame(tabla2)

#Gráfica
p <- ggplot(tabla2, aes(x = Var1 , y = Freq)) + 
  geom_bar (stat="identity", fill = 'blue') +
  xlab("Goles") +
  ggtitle('Equipo de visita')
p
```

![bb459880-6de5-4539-8de8-6d1562acdc89](https://user-images.githubusercontent.com/72113099/106953118-a10ef780-66f7-11eb-85cb-3704966331fe.png)

La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
Por último, no olvides cerrar la conexión con la BDD
```R
#Probabilidad conjunta
tabla3 <- prop.table(table(lista.final$FTHG, lista.final$FTAG)) * 100

#Tabla a data.frame
tabla3 <- as.data.frame(tabla3)

#Cambio de nombre de variables
tabla3 <- rename(tabla3, gol.local = Var1, gol.visita = Var2, Probabilidad = Freq)

#Gráfica
ggplot(tabla3, aes(x = gol.local, y = gol.visita, fill = Probabilidad)) + 
  geom_tile() +
  scale_fill_gradient(low = "white", high = "steelblue") +
  ggtitle('Probabilidades conjuntas')

```

![62d47953-de29-4d12-be85-a4a584f20330](https://user-images.githubusercontent.com/72113099/106953131-a3715180-66f7-11eb-92d1-5aaa159f76f9.png)
