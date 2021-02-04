# Postwork Sesión 5


#1 Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 
u1718 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
u1819 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
u1920 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"

download.file(url = u1718, destfile = "SP1-1718.csv", mode = "wb")
download.file(url = u1819, destfile = "SP1-1819.csv", mode = "wb")
download.file(url = u1920, destfile = "SP1-1920.csv", mode = "wb")

lista <- lapply(dir(), read.csv) # Guardamos los archivos en lista

# crea el data frame SmallData, que contenga las columnas date, home.team, home.score, away.team y away.score
library(dplyr)
listaF <-lapply(lista, select,Date,HomeTeam,FTHG,AwayTeam,FTAG)
SmallData <-lapply(listaF, rename,home.team=HomeTeam,home.score=FTHG,away.team=AwayTeam,away.score=FTAG)


head(SmallData[[1]]); head(SmallData[[2]]); head(SmallData[[3]]);
tail(SmallData[[1]]); tail(SmallData[[2]]); tail(SmallData[[3]]);


SmallData[[1]] <- mutate(SmallData[[1]], Date = as.Date(Date,"%d/%m/%y"))
SmallData[[2]] <- mutate(SmallData[[2]], Date = as.Date(Date,"%d/%m/%y"));
SmallData[[3]] <- mutate(SmallData[[3]], Date = as.Date(Date,"%d/%m/%y"));

SmallData <- do.call(rbind, SmallData)
#dim(SmallData)
class(SmallData)

# Con ayuda de la función write.csv guarda el data frame como un archivo csv
# con nombre soccer.csv.
write.csv(SmallData,"soccer.csv", row.names = FALSE)
#dir()
class(SmallData$Date)

###########################################################################
# 2 fbRanks
install.packages("fbRanks")
library(fbRanks)

# ?create.fbRanks.dataframes
# Helper Function to Construct the Scores and Teams Data Frames from csv files.
listasoccer<-create.fbRanks.dataframes("soccer.csv",
                                       team.resolver=NULL,
                                       #teams.file=NULL,
                                       date.format="%Y-%m-%d",
                                       na.remove=FALSE)


listasoccer
scores<-listasoccer$scores
teams <-listasoccer$teams

#############################################################################
# 3
# Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan
# y que correspondan a las fechas en las que se jugaron partidos
?unique
fecha<-unique(listasoccer$scores$date)
#fecha2<-unique(SmallData$Date)

# Crea una variable llamada n que contenga el número de fechas diferentes.
n<-length(fecha);
n
head(fecha);tail(fecha);
fecha<-sort(fecha)
head(fecha);tail(fecha);

?rank.teams
ranking <- rank.teams(scores,teams,
           family="poisson", fun="glm",
           max.date=fecha[n-1], min.date=fecha[1], date.format="%Y-%m-%d",
           time.weight.eta=0, add=NULL, silent=FALSE)


#############################################################################
#4 Finalmente estima las probabilidades de los eventos, 
?predict.fbRanks
predict.fbRanks(ranking,
  #newdata=list(home.team=listasoccer$teams, away.team="away.team"),
  
  #max.date=fecha[n], 
  min.date=fecha[n]);
