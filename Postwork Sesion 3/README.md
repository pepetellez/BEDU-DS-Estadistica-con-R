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
