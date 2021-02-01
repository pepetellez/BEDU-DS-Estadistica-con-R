func_marginales<-function(data){

data.prob18_20<- muestra
#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
pm.FTHG.n <- as.data.frame(prop.table(table(data.prob18_20$FTHG)))
pm.FTHG.n <- rename(pm.FTHG.n, GolesH = Var1)
pm.FTHG.n <- rename(pm.FTHG.n, FreqH = Freq)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
pm.FTAG.n <- as.data.frame(prop.table(table(data.prob18_20$FTAG)))
pm.FTAG.n <- rename(pm.FTAG.n, GolesA = Var1)
pm.FTAG.n <- rename(pm.FTAG.n, FreqA = Freq)

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
pc.tabla.n <- prop.table(table(data.prob18_20$FTHG, data.prob18_20$FTAG)) * 100
pc.FTG.n <- as.data.frame(prop.table(table(data.prob18_20$FTHG, data.prob18_20$FTAG)) * 100)

# La multiplicación de las marginales
pc.FTG.n$FreqH <- rep(pm.FTHG.n$FreqH,each = dim(pc.tabla.n)[2])
pc.FTG.n$FreqA <- rep(pm.FTAG.n$FreqA, each = dim(pc.tabla.n)[1])
pc.FTG.n$Cocientes <- pc.FTG.n$Freq/(100*pc.FTG.n$FreqH*pc.FTG.n$FreqA)

library(reshape2)
tabla.cocientes <- acast(pc.FTG.n, Var1~Var2, value.var="Cocientes")

#Resultado
p.results <- list(p.casa=pm.FTHG.n, p.visita = pm.FTAG.n, 
                  p.conjuta = pc.tabla.n, p.cocientes= tabla.cocientes[1:5,1:5])
p.results

} 
