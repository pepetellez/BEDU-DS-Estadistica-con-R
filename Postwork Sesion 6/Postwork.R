# Postwork Sesion 6
# Equipo 12

# Librerias y espacio de trabajo:
library(dplyr)
library(xts)
setwd("C:/Users/alana/Documents/GitHub/Data-Science/Modulo 2/Sesion 6/Postwork Files")

# 1.- Agrega una nueva columna sumagoles que contenga la suma de goles por partido.}
data <- read.csv("match.data.csv")
head(data)
dim(data)
sumagoles <- data$home.score + data$away.score
data <- cbind(data, sumagoles)
# 2.- Obtén el promedio por mes de la suma de goles.
data <- mutate(data, date = as.Date(date, "%Y-%m-%d"))
data <- mutate(data, date = format(date,"%Y-%m"))
newData <- select(data, date, sumagoles)
gNewData <- newData %>% group_by(date) %>% summarise(meangoles = mean(sumagoles))
head(newData)
head(gNewData)


# 3.- Crea la serie de tiempo del promedio por mes de la suma de goles hasta 
#     diciembre de 2019. Grafica la serie de tiempo.

data.ts <- ts(gNewData$meangoles, st = c(2010, 8), end = c(2019, 12), fr = 12)
plot(data.ts)
