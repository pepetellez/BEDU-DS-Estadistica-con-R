# Postwork Sesión 4.

### Solución

#### Objetivo

Investigar la dependencia o independecia de las variables aleatorias X y Y, el número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.

#### Desarrollo
Investigar la dependencia o independencia del número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap

1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.
-- Obtener una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior.
-- Obten una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. 
-- Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).

#### Codigo 

Importación de datos y librerias
```R
library(dplyr)
library(reshape2)
library(ggplot2)
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

tabla.cocientes <- acast(pc.FTG, Var1~Var2, value.var="Cocientes")
tabla.cocientes
```
![PCTABLA](https://user-images.githubusercontent.com/71915068/105949628-9935c000-6032-11eb-9514-06c23793d355.PNG)

#### 2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior.
```R
#muestra del mismo tamaño con remplazo repitiendo el experimento 1000 veces
all.freq <- matrix(nrow = 1000, ncol = 25)


#Este ciclo obtiene concientes similares antes calculados
for (rep in 1:1000) {
  
  id <- sample(dim(lspain18_20)[1], size = 440, replace = T)
  head(id)
  muestra <- lspain18_20[id,]
  head(muestra)
  
  #Con ayuda de la funcion table obtenemos las estimaciones de probabilidades
  
  ###Es necesario cargar la funcion_marginales. La creamos ya que nos ayuda a reciclar codigo y nos ahorra un poco de tiempo.
  estimaciones <- func_marginales(muestra) 
  
  iter = 0
  for (i in 1:5) {
    for (j in 1:5) {
      iter = iter+ 1
      #Se ira llenando por columnas
      all.freq[rep,iter] <- estimaciones$p.cocientes[i,j]
    }
  }
}


#Creamos un vector con los nombres para que aparezcan en los gráficos

all.cocientes<-as.data.frame(all.freq)

(col.f <- rep(0:4,times = 5))
(row.f <- rep(0:4,each = 5))
names <- paste(row.f,col.f) #Este vector nos ayudara a identificar cada caso


# Gráficamos un histograma con 1000 estimaciones por caso de goles anotados y de visita
par(mfrow=c(5,5))

l = 0
for (variable in names) {
  l = l + 1
  hist(all.cocientes[,l], main = variable, xlab = "p.conjunta.boostrap")
}

dev.off()  
```
#### boostrap (filas = FTHG, columnas = FTAG)
![boostrap_probabilidad_conjunta_cocientes](https://user-images.githubusercontent.com/71915068/106407655-3eb9ac80-6402-11eb-82bd-95857f156bab.png)

#### 3. Conclusiones.
Podemos observar la distribución de cada uno de los casos para goles en casa y visita. Una distribución normal y cerca a uno indica una mayor probabilidad de que ocurra el evento. Tambien notamos que para los casos (0,0) o (1,1) su media es de de uno. Mientras más aumenta la cantida de goles ya sea en casa o de vista la distribución deja de ser normal, aumenta la varianza, deja de estar centrado en 1 y hay poca probabilidad de predicción para estos resultados.

Por otro lado notaremos que en algunos casos la distribución es normal pero no esta centrado y notamos una ligero sesgo a la derecha o a la izquierda, por ejemplo: oberve el caso un gol en casa y cero de visita, quizas esto puede indicar que este evento ocurre con mayor probabilidad de exito ya que esta ligeramente sesgada a la izquierda con un media ligeramente mayor a 1. Por otro lado el caso contrario un gol de visita y cero en casa notamos que la distribución es normal pero este evento indicaria un menor probabilidad de exito ya que la distribución esta ligeramente sesgada a la derecha con una media ligeramente menor a 1. Aqui podemos notar ese contraste y la utilidad de la tecnica boostrap cuando tenemos menor cantidad de datos finita.


| H/A  |0   |1   | 2  | 3  |4   |
|---|---|---|---|---|---|
|0   |ditribución normal, poca varianza, centrado, predecible   |distribución normal, poca varianza, sesgado a la derecha, predecible|No normal, sesgada a la derecha, poco, predecible, alta varianza|No normal, sesgada a la derecha, poco, predecible, alta varianza|No normal, sesgada a la derecha, poco, predecible, alta varianza|
|1  |ditribución normal, poca varianza, no centrado, predecible   |ditribución normal, poca varianza, centrado, predecible  | No normal, sesgada a la derecha, poco, predecible, alta varianza |  No normal, sesgada a la derecha, poco, predecible, alta varianza | ... |
|2  | ditribución normal, poca varianza, no centrado, predecible  |ditribución normal, poca varianza, centrado, predecible | No normal, sesgada a la derecha, poco, predecible, alta varianza  | ...  | ...  |
|3  | ditribución normal, poca varianza, no centrado, predecible  |ditribución normal, poca varianza, no centrado, predecible|...|...|...|
|4  |ditribución normal, poca varianza, no centrado, predecible   | ...  | ... | ... | ... |

Alternativamente podemos realizar la misma tarea importando `library(boot)` y `boot` para el remuestrear
```R
library(boot)
stat_fun <- function(x, idx) mean(x[idx])
boot_obj <- boot(pc.FTG$Cocientes, R=10000, statistic=stat_fun)
boot_obj
```
