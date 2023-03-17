#Ciscenje radne povrsine
rm(list = ls())

#Definiranje potrebnih knjiznica
library(leaflet)
library(sp)
library(raster)

#Ucitavanje uzorka opazanja iz Sensor_record.csv datoteke
setwd('E:/Desktop/Tema4 - Seminar')
data <- read.csv('Sensor_record.csv', header=TRUE)

#Podaci o lokaciji
data.pos <- data[,c(23:25)]
data.pos <- na.omit(data.pos)
colnames(data.pos) <- c('latitude', 'longitude', 'height')

#Podaci akcelerometra
data.acc <- data[,c(1:3)]
data.acc <- na.omit(data.acc)
colnames(data.acc) <- c('accx', 'accy', 'accz')

#Vrijeme
data.time <- data[,c(33:33)]
date <- as.POSIXlt(data.time)
time <- date$hour/24 + date$min/(24*60) + date$sec/(24*3600) 

#Graficki prikaz podataka
plot(time,data.acc$accx, col = 'red', type='l', main='Varijabla akcelerometra -x os kroz vrijeme', xlab='Vrijeme', ylab='Vrijednost')
plot(time,data.acc$accy, col = 'blue', type='l', main='Varijabla akcelerometra -y os kroz vrijeme', xlab='Vrijeme', ylab='Vrijednost')
plot(time,data.acc$accz, col = 'green', type='l', main='Varijabla akcelerometra -z os kroz vrijeme', xlab='Vrijeme', ylab='Vrijednost')

#Opisna statisticka analiza varijabli akcelerometra
print('Satisticka analiza varijable akcelerometra -x os: ')
print(summary(data.acc$accx))
print('Standardna devijacija varijable akcelerometra -x os: ')
print(sd(data.acc$accx))
print('Satisticka analiza varijable akcelerometra -y os: ')
print(summary(data.acc$accy))
print('Standardna devijacija varijable akcelerometra -y os: ')
print(sd(data.acc$accy))
print('Satisticka analiza varijable akcelerometra -z os: ')
print(summary(data.acc$accz))
print('Standardna devijacija varijable akcelerometra -z os: ')
print(sd(data.acc$accz))

##Graficki prikaz statisticke analize - Kutijasti dijagrami
boxplot(data.acc$accx, col = 'red', main='Kutijasti diagram varijable akcelerometra -x os', xlab='Vrijednost opazanja', ylab='Kvartili')
boxplot(data.acc$accy, col = 'blue', main='Kutijasti diagram varijable akcelerometra -y os', xlab='Vrijednost opazanja', ylab='Kvartili')
boxplot(data.acc$accz, col = 'green', main='Kutijasti diagram varijable akcelerometra -z os', xlab='Vrijednost opazanja', ylab='Kvartili')

#Eksperimentalne statisticke razdiobe varijabli

#Procjena eksperimentalne gustoce vjerojatnosti
plot(density(data.acc$accx), col='red', main='Eksperimentalna gustoca vjerojatnosti varijable akcelerometra -x os', xlab='Akcelerometar x-os', ylab='Vjerojatnost pojave')
plot(density(data.acc$accy), col='blue', main='Eksperimentalna gustoca vjerojatnosti varijable akcelerometra -y os', xlab='Akcelerometar y-os', ylab='Vjerojatnost pojave')
plot(density(data.acc$accz), col='green', main='Eksperimentalna gustoca vjerojatnosti varijable akcelerometra -z os', xlab='Akcelerometar z-os', ylab='Vjerojatnost pojave')

#Statisticki testovi - Kolmogorov-Smirnov i Shapiro-Wilkov
print(shapiro.test(data.acc$accx))
print(shapiro.test(data.acc$accy))
print(shapiro.test(data.acc$accz))
print(ks.test(data.acc$accx, 'pnorm'))
print(ks.test(data.acc$accy, 'pnorm'))
print(ks.test(data.acc$accz, 'pnorm'))

#Prilagodba podataka za crtanje putanje na Leaflet mapi
print(summary(data.pos))
plot(data.pos$longitude, data.pos$latitude, main='Prikaz putanje kretanja', xlab = "Geografska duzina", ylab = " Geografska sirina")
lonlat <- cbind(data.pos$longitude, data.pos$latitude)
pts <- SpatialPoints(lonlat)
crdref <- CRS('+proj=longlat +datum=WGS84')
pts <- SpatialPoints(lonlat, proj4string=crdref)
lns <- spLines(lonlat, crs=crdref)

#Priprema tocaka za interakciju na Leaflet mapi
#Za iscrtavanje uzeta svaka 17. tocka putanje kretanja
interval_of_dots <- 17
lat_nth <- data.pos$latitude[seq(1, length(data.pos$latitude), interval_of_dots)]
lon_nth <- data.pos$longitude[seq(1, length(data.pos$longitude), interval_of_dots)]
time_nth <- date[seq(1, length(date), interval_of_dots)]
accX_nth <- data.acc$accx[seq(1, length(data.acc$accx), interval_of_dots)]
accY_nth <- data.acc$accy[seq(1, length(data.acc$accy), interval_of_dots)]
accZ_nth <- data.acc$accz[seq(1, length(data.acc$accz), interval_of_dots)]
alt_nth <- data.pos$height[seq(1, length(data.pos$height), interval_of_dots)]

#Deklaracija leaflet mape, dodavanje putanje kretanja i prikaz interaktivnih tocaka
map <- leaflet() 
map <- addTiles(map)


map <- addCircleMarkers(map,lng = lon_nth, lat = lat_nth, 
                 color = 'blue', 
                 popup = paste("<b>Vrijeme:", time_nth, "</b><br>",
                               "Geografska duzina:", lon_nth, "<br>",
                               "Geografska sirina:", lat_nth, "<br>",
                               "Geografska visina:", alt_nth, " m <br>",
                               "Akcelerometar X:", accX_nth, " m/s<sup>2</sup> <br>",
                               "Akcelerometar Y:", accY_nth, " m/s<sup>2</sup><br>",
                               "Akcelerometar Z:", accZ_nth, " m/s<sup>2</sup> <br>"),
                 radius = 6,
                 stroke = FALSE, fillOpacity = 0.4) 

map <- addPolylines(map,
                    data = lns,
                    color = "red",
                    weight = 1.5,
                    smoothFactor = 0.8,
                    opacity = 1.0)
map

