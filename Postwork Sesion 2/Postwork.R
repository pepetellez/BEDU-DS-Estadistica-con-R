# Postwork Sesion 2
# Equipo 12

setwd("C:/Users/alana/Documents/GitHub/Data-Science/Modulo 2/Sesion 2/Postwork Files")

# 1.- Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de
# la primera división de la liga española a R, los datos los puedes encontrar en el 
# siguiente enlace: https://www.football-data.co.uk/spainm.php

u1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")

lista <- lapply(dir(), read.csv)

# 2.- Obten una mejor idea de las características de los data frames al usar las 
# funciones: str, head, View y summary
str(lista[1])
head(lista[1])
View(lista[1])
summary(lista[1])

# 3.- Con la función select del paquete dplyr selecciona únicamente las columnas
# Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames.
library(dplyr)
lista <- lapply(lista, select, Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
head(lista[[1]]); head(lista[[2]]); head(lista[[3]])

# 4.- Asegúrate de que los elementos de las columnas correspondientes de los nuevos
# data frames sean del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las 
# fechas). Con ayuda de la función rbind forma un único data frame que contenga las
# seis columnas mencionadas en el punto 3 (Hint 2: la función do.call podría ser utilizada).

head(lista[1])
lista[[1]] <- mutate(lista[[1]], Date = as.Date(Date, "%d/%m/%y"))
View(lista[[1]])

head(lista[2])
lista[[2]] <- mutate(lista[[2]], Date = as.Date(Date, "%d/%m/%Y"))
View(lista[[2]])

head(lista[3])
lista[[3]] <- mutate(lista[[3]], Date = as.Date(Date, "%d/%m/%Y"))
View(lista[[3]])

data <- do.call(rbind, lista)
head(data)
tail(data)
View(data)
