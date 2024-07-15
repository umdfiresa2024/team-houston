library("tidyverse")
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
  mutate(coef=as.numeric(coef), change_bicycle = change_bicycle*100, change_walked=change_walked*100, change_bus = change_bus*100, change_car=change_car*100)
write.csv(pum_coef,'pum_coef.csv')


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
png(filename="Bicyclemap.png", width=900, height=800, units="px")

plot(bg, alpha=0.05)
plot(shapevect, add=TRUE)
plot(shape_coef, 
     "change_bicycle",
     type="interval",
     breaks=c(-101,-100,-99.7,-99.5,-99.6),
     col=map.pal("reds"),
     cex.main =2.125,
     plg=list( # parameters for drawing legend
       title = "Change in Bicycle Use \n (in Percents)",
       title.cex = 1.5, # Legend title size
       cex = 2),
     add=TRUE)
title("Average Bicycle Use Changes\n (in Percents) After Light Rail Openings", line=-50, adj=0.45,cex.main=2)
plot(buff, add=TRUE)
dev.off()

png(filename="Walkedmap.png", width=900, height=800, units="px")
plot(bg, alpha=0.05)
plot(shapevect, add=TRUE)
plot(shape_coef, 
     "change_walked",
     type="interval",
     breaks=c(-100, -99,-99.65,-98.5, -98),
     col=map.pal("grass"),
     plg=list( # parameters for drawing legend
       title = "Change in Walking Use \n (in Percents)",
       title.cex = 1.5, # Legend title size
       cex = 2),
     add=TRUE)
title("Average Walking Use Changes\n (in Percents) After Light Rail Openings", line=-50, adj=0.45,cex.main=2)
plot(buff, add=TRUE)
dev.off()

png(filename="Busmap.png", width=900, height=800, units="px")

plot(bg, alpha=0.05)
plot(shapevect, add=TRUE)
plot(shape_coef, 
     "change_bus",
     type="interval",
     breaks=c(-100,-99,-98,-97.8,-97.5),
     col=map.pal("blues"),
     plg=list( # parameters for drawing legend
       title = "Change in Bus Use \n (in Percents)",
       title.cex = 1.5, # Legend title size
       cex = 2),
     add=TRUE)
title("Average Bus Use Changes\n (in Percents) After Light Rail Openings", line=-50, adj=0.45,cex.main=2)
plot(buff, add=TRUE)
dev.off()

png(filename="Carmap.png", width=900, height=800, units="px")
plot(bg, alpha=0.05)
plot(shapevect, add=TRUE)
plot(shape_coef, 
     "change_car",
     type="interval",
     breaks=c(100,13,3.7,2.56,2.55),
     col=map.pal("oranges"),
     plg=list( # parameters for drawing legend
       title = "Change in Car Use \n (in Percents)",
       title.cex = 1.5, # Legend title size
       cex = 2),
     add=TRUE)
title("Average Car Use Changes\n (in Percents) After Light Rail Openings", line=-50, adj=0.45,cex.main=2)
plot(buff, add=TRUE)
dev.off()


