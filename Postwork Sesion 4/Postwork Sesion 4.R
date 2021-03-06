#Investigar la dependencia o independecia de las variables aleatorias X y Y, el n�mero de goles anotados por el equipo de casa y el n�mero de goles anotados por el equipo visitante.

#Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el 
#equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obt�n una tabla de cocientes al dividir estas
#probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

lspain18_20<-read.csv("LSPAIN18_20.csv")

#library(dplyr)
#library(reshape2)
#library(ggplot2)

#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
pm.FTHG <- as.data.frame(prop.table(table(lspain18_20$FTHG)))
pm.FTHG <- rename(pm.FTHG, GolesH = Var1)
pm.FTHG <- rename(pm.FTHG, FreqH = Freq)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
pm.FTAG <- as.data.frame(prop.table(table(lspain18_20$FTAG)))
pm.FTAG <- rename(pm.FTAG, GolesA = Var1)
pm.FTAG <- rename(pm.FTAG, FreqA = Freq)

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
pc.tabla <- prop.table(table(lspain18_20$FTHG, lspain18_20$FTAG)) * 100
pc.FTG <- as.data.frame(prop.table(table(lspain18_20$FTHG, lspain18_20$FTAG)) * 100)

# La multiplicaci�n de las marginales
pc.FTG$FreqH <- rep(pm.FTHG$FreqH,7)
pc.FTG$FreqA <- rep(pm.FTAG$FreqA, each = 9)
pc.FTG$Cocientes <- pc.FTG$Freq/(100*pc.FTG$FreqH*pc.FTG$FreqA)


tabla.cocientes <- acast(pc.FTG, Var1~Var2, value.var="Cocientes")
tabla.cocientes


#Mediante un procedimiento de boostrap, obt�n m�s cocientes similares a los obtenidos en la tabla del punto 
#anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla 
#anterior. Menciona en cu�les casos le parece razonable suponer que los cocientes de la tabla en el
#punto 1, son iguales a 1 (en tal caso tendr�amos independencia de las variables aleatorias X y Y).


#muestra del mismo tama�o con remplazo repitiendo el experimento 1000 veces
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


#Creamos un vector con los nombres para que aparezcan en los gr�ficos

all.cocientes<-as.data.frame(all.freq)

(col.f <- rep(0:4,times = 5))
(row.f <- rep(0:4,each = 5))
names <- paste(row.f,col.f) #Este vector nos ayudara a identificar cada caso


# Gr�ficamos un histograma con 1000 estimaciones por caso de goles anotados y de visita
par(mfrow=c(5,5))

l = 0
for (variable in names) {
  l = l + 1
  hist(all.cocientes[,l], main = variable, xlab = "p.conjunta.boostrap")
}

dev.off()  