# Postwork Sesión 2.

#### Objetivo

Investigar la dependencia o independecia de las variables aleatorias X y Y, el número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.

#### Desarrollo
Investigar la dependencia o independencia del número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap

1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
-- Obtener una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior.
-- Obten una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. 
-- Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).

#### Solución

Importación de datos y librerias
```R
library(dplyr)
lspain18_20<-read.csv("LSPAIN18_20.csv")
```

Obtenemos las frecuencias marginales y conjuntas
```R
#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
pm.FTHG <- as.data.frame(prop.table(table(lspain18_20$FTHG)))
pm.FTHG <- rename(pm.FTHG, GolesH = Var1)
pm.FTHG <- rename(pm.FTHG, FreqH = Freq)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
pm.FTAG <- as.data.frame(prop.table(table(lspain18_20$FTAG)))
pm.FTAG <- rename(pm.FTAG, GolesA = Var1)
pm.FTAG <- rename(pm.FTAG, FreqA = Freq)

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega 
# como visitante anote y goles (x=0,1,2,, y=0,1,2,)

pc.FTG <- as.data.frame(prop.table(table(lspain18_20$FTHG, lspain18_20$FTAG)) * 100)
```

#### 1. Obtenemos una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
```R
pc.FTG$FreqH <- rep(pm.FTHG$FreqH,7)
pc.FTG$FreqA <- rep(pm.FTAG$FreqA, each = 9)
pc.FTG$Cocientes <- pc.FTG$Freq/(100*pc.FTG$FreqH*pc.FTG$FreqA)

ggplot(pc.FTG, aes(Cocientes)) + 
  geom_histogram()
```
![PCTABLA](https://user-images.githubusercontent.com/71915068/105949628-9935c000-6032-11eb-9514-06c23793d355.PNG)

#### 2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior.
```R
#muestra del mismo tamaño con remplazo repitiendo el experimento 1000 veces
boostrap <- replicate(n = 10000, sample(pc.FTG$Cocientes, replace = T))
dim(boostrap)

#Calculamos las medias a cada columna y la almacenamos en medias
medias<-apply(boostrap, 2, mean)
medias

#Calculamos la desviación de cada medias con la media muestral para calcular el "error estandar"
sqrt(sum((medias-xbarra)^2)/ncol(boostrap))

ggplot() + geom_histogram(aes(x=medias),bins=50, color="black", fill="white")+
  geom_vline(xintercept = mean(medias), linetype="dashed", color = "red", size=1) + 
  geom_text(aes(label=round(mean(medias),3),y=650,x=mean(medias)),
            vjust=-1,col='blue',size=4)
```

Alternativamente podemos realizar la misma tarea importando `library(boot)` y `boot` para el estadistico de la media
```R
library(boot)
stat_fun <- function(x, idx) mean(x[idx])
boot_obj <- boot(pc.FTG$Cocientes, R=10000, statistic=stat_fun)
boot_obj
```
