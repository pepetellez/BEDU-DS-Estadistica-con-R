library(dplyr)

liga.spain <- read.csv("SP12019.csv")

FTHG <- liga.spain %>% select(HomeTeam, FTHG) %>% group_by(HomeTeam, FTHG) %>% count(HomeTeam)
