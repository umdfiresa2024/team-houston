library("tidyverse")
library('terra')
buff<-vect("buff_sta.shp") #stations shapefile

library('sp')
library('tigris')
shape<-tigris::pumas(state="TX",class="sp", year=2012)
shapevect<-vect(shape) 
shapevect$pumnum<-as.numeric(shapevect$PUMACE10)
shapevect<-subset(shapevect, shapevect$pumnum>4600 & shapevect$pumnum<4604)

output<-c()

for(i in 0:24){
  print(i)
  buff2 <-subset(buff, buff$FID ==i)
  int<-crop(shapevect, buff2)
  intdf<-as.data.frame(int) %>%
    mutate(city_num=i+1) %>%
    mutate(intarea=expanse(int, unit="m"))
    
  output<-rbind(output, intdf)
}

output2<-output %>%
  group_by(city_num) %>%
  mutate(maxarea=max(intarea)) %>%
  filter(intarea==maxarea) %>%
  select(PUMACE10, city_num)

#run regressions with pum

df3 <- read.csv('regression_analysis_data') 

df4<-merge(df3, output2, by="city_num")

summary(m1 <- lm(log(pm25) ~ MetroOpen:as.factor(PUMACE10) + construction + 
                   TERP + NAAQS +
                   temp + lag_temp + lag_temp_2 + lag_temp_3 + lag_temp_4 + 
                   wind + lag_wind + lag_wind_2 + lag_wind_3 + lag_wind_4 + 
                   humidity + lag_humidity + lag_humidity_2 + lag_humidity_3 +
                   lag_humidity_4 + 
                   as.factor(month) + as.factor(dow) + holiday + 
                   t + t2 + t3 + t4, data = df4))
#library('broom')
#write.csv(tidy(m1), 'PM2.5PollutionByPumaRegressionModel.csv')
n<-length(coef(m1))
coef<-coef(m1)[42:43]
PUMACE10<-c("04602", "04603")
coefdf<-as.data.frame(cbind(coef, PUMACE10))
  
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

########plot station-level reduction###################

output4<-output2 |>
  mutate(FID=city_num-1)

output5<-merge(output4, coefdf, by="PUMACE10") |>
  mutate(coef=as.numeric(coef)*100)

buff2<-merge(buff, output5, by="FID")

library("maptiles")

osmpos <- create_provider(name = "CARTO.POSITRON",
                          url = "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                          sub = c("a", "b", "c", "d"),
                          citation = "© OpenStreetMap contributors © CARTO ")

buff3<-buffer(buff2, width=2000)
bg <- get_tiles(ext(buff3),provider = osmpos, crop = TRUE)

png(filename="PM2.5PerStationmap.png", width=800, height=800, units="px")
plot(bg, alpha=0.05)
plot(shapevect, add=TRUE)
plot(buff2, 
     "coef",
     type="interval",
     breaks=c(-35, -30, -25, -20, -15),
     col=map.pal("inferno"),
     cex.main=2.125,
     main="Average PM2.5 Change \n at Each Light Rail Station",
     plg=list( # parameters for drawing legend
       title = "Change in PM2.5 \n (in Percents)",
       title.cex = 1.5, # Legend title size
       cex = 2),
     add=TRUE) #legend text size

dev.off()

