#calculate change
pum4<-read.csv("puma2004.csv") |>
  mutate(PUMACE10=substr(Selected.Geographies, 6, 10)) |>
  filter(PUMACE10=="04602" | PUMACE10=="04603" | PUMACE10=="04604") |>
  mutate(pct_car=Car.truck.van/Total,
         pct_bus=Bus.or.trolley.bus/Total,
         pct_subway=Subway.or.elevated/Total,
         pct_taxicab=Taxicab/Total,
         pct_motorcycle=Motorcycle/Total,
         pct_walked=Walked/Total,
         pct_worked_at_home=Worked.At.Home/Total,
         pct_bicycle=Bicycle/Total) 


pum8<-read.csv("puma2008.csv") |>
  mutate(PUMACE10=substr(Selected.Geographies, 6, 10)) |>
  filter(PUMACE10=="04602" | PUMACE10=="04603" | PUMACE10=="04604") |>
  mutate(pct_car08=Car.truck.van/Total,
         pct_bus08=Bus.or.trolley.bus/Total,
         pct_subway08=Subway.or.elevated/Total,
         pct_taxicab08=Taxicab/Total,
         pct_motorcycle08=Motorcycle/Total,
         pct_walked08=Walked/Total,
         pct_worked_at_home08=Worked.At.Home/Total,
         pct_bicycle08=Bicycle/Total) 

pum<-merge(pum4, pum8, by="PUMACE10") |>
  mutate(change_car=(pct_car08-pct_car)/pct_car,
         change_bus=(pct_bus08-pct_bus/pct_bus),
         change_subway=(pct_subway08-pct_subway/pct_subway),
         change_taxicab=(pct_taxicab08-pct_taxicab/pct_taxicab),
         change_motorcycle=(pct_motorcycle08-pct_motorcycle)/pct_motorcycle,
         change_walked=(pct_walked08-pct_walked/pct_walked),
         change_worked_at_home=(pct_worked_at_home08-pct_worked_at_home/pct_worked_at_home),
         change_bicycle=(pct_bicycle08-pct_bicycle/pct_bicycle))
pum_2 <-pum %>%
  select(PUMACE10, change_car,change_bus,change_subway,change_taxicab,change_motorcycle,change_walked,change_worked_at_home, change_bicycle)

pum_coef<-merge(pum_2, coefdf, by="PUMACE10") |>
  mutate(coef=as.numeric(coef))
write.csv(pum_coef,'pum2.csv')


shape<-tigris::pumas(state="TX",class="sp", year=2012)
shapevect<-vect(shape) 

shape_coef<-merge(shapevect, pum_coef, by="PUMACE10")

plot(shape_coef, 
     "change_bicycle",
     type="interval",
     breaks=c(-1, -0.9),
     col=map.pal("grass"),
     main="Average PM2.5 Changes (in Percents) Due to Light Rail Openings")
plot(buff, add=TRUE)

#save plot as image file
png(filename="Bicyclemap.png", width=1000, height=700, units="px")

plot(shape_coef, 
     "change_bicycle",
     type="interval",
     breaks=c(-2,-1,-0.999,-0.996, -0.995),
     col=map.pal("reds"),
     main="Average Bicycle Use Changes (in Percents) After Light Rail Openings",
     cex.main =2.125)
plot(buff, add=TRUE)
dev.off()

png(filename="Walkedmap.png", width=1000, height=700, units="px")

plot(shape_coef, 
     "change_walked",
     type="interval",
     breaks=c(-1, -0.99,-9.95,-0.985, -0.98),
     col=map.pal("greens"),
     main="Average Walking Use Changes (in Percents) After Light Rail Openings",
     cex.main = 2.125)
plot(buff, add=TRUE)
dev.off()

png(filename="Busmap.png", width=1000, height=700, units="px")

plot(shape_coef, 
     "change_bus",
     type="interval",
     breaks=c(-1,-0.985,-0.980,-0.9785,-0.978,-0.975),
     col=map.pal("blues"),
     main="Average Bus Use Changes (in Percents) After Light Rail Openings",
     cex.main=2.125)
plot(buff, add=TRUE)
dev.off()

png(filename="Carmap.png", width=1000, height=700, units="px")

plot(shape_coef, 
     "change_car",
     type="interval",
     breaks=c(1,0.13,0.037,0.0256,0.0255),
     col=map.pal("oranges"),
     main="Average Car Use Changes (in Percents) After Light Rail Openings",
     cex.main=2.215)
plot(buff, add=TRUE)
dev.off()


