library("terra")

buff<-vect("buff_sta.shp") #stations shapefile

#get puma shapefile
library('sp')
library('tigris')
shape<-tigris::pumas(state="TX",class="sp", year=2012)
shapevect<-vect(shape) 
shapevect$pumnum<-as.numeric(shapevect$PUMACE10)
shapevect<-subset(shapevect, shapevect$pumnum>4600 & shapevect$pumnum<4606)
shapedf<-as.data.frame(shape)

plot(buff)
plot(shapevect, "pumnum", add=TRUE, alpha=0.2)

#clean puma data for 2004
pum4<-read.csv("puma2004.csv") |>
  mutate(PUMACE10=substr(Selected.Geographies, 6, 10)) |>
  rename(Streetcar.or.trolley.car = Streetcar.or.trolley.car..carro.publico.in.Puerto.Rico.)

blockrace<-merge(shapevect, pum4, by="PUMACE10")

blockrace$blockarea<-expanse(blockrace, unit="m")

blockracedf<-as.data.frame(blockrace)

summary(blockracedf)

#intersect puma with stations
buffdf <- as.data.frame(buff)

output<-c()

for(i in 0:24){
  print(i)
  buff2 <-subset(buff, buff$FID ==i)
  int<-crop(blockrace, buff2)
  int$intarea<-expanse(int, unit="m")
  intdf<-as.data.frame(int) %>%
    mutate(frac_area=intarea/blockarea) %>%
    mutate(Total=Total*frac_area, 
           Car.truck.van=Car.truck.van*frac_area,
           Bus.or.trolley.bus = Bus.or.trolley.bus*frac_area,
           Streetcar.or.trolley.car=Streetcar.or.trolley.car*frac_area,
           Subway.or.elevated=Subway.or.elevated*frac_area,
           Railroad=Railroad*frac_area,
           Ferry.boat=Ferry.boat*frac_area,
           Taxicab=Taxicab*frac_area,
           Motorcycle=Motorcycle*frac_area,
           Bicycle=Bicycle*frac_area,
           Walked=Walked*frac_area,
           Worked.At.Home=Worked.At.Home*frac_area,
           Other=Other*frac_area) |>
    summarize(Total=sum(Total), 
              Car.truck.van=sum(Car.truck.van),
              Bus.or.trolley.bus=sum(Bus.or.trolley.bus),
              Streetcar.or.trolley.car=sum(Streetcar.or.trolley.car),
              Subway.or.elevated=sum(Subway.or.elevated),
              Railroad=sum(Railroad),
              Ferry.boat=sum(Ferry.boat),
              Taxicab=sum(Taxicab),
              Motorcycle=sum(Motorcycle),
              Bicycle=sum(Bicycle),
              Walked=sum(Walked),
              Worked.At.Home=sum(Worked.At.Home),
              Other=sum(Other)) %>%
    mutate(pct_Car.truck.van=Car.truck.van*100/Total,
           pct_Bus.or.trolley.bus=Bus.or.trolley.bus*100/Total,
           pct_Streetcar.or.trolley.car=Streetcar.or.trolley.car*100/Total,
           pct_Subway.or.elevated=Subway.or.elevated*100/Total,
           pct_Railroad=Railroad*100/Total,
           pct_Ferry.boat=Ferry.boat*100/Total,
           pct_Taxicab=Taxicab*100/Total,
           pct_Motorcycle=Motorcycle*100/Total,
           pct_Bicycle=Bicycle*100/Total,
           pct_Walked=Walked*100/Total,
           pct_Worked.At.Home=Worked.At.Home*100/Total,
           pct_Other=Other*100/Total) %>%
    mutate(FID=i)
  
  output<-rbind(output, intdf)
}

#compare results with puma 2008
pum8<-read.csv("puma2008.csv") |>
  mutate(PUMACE10=substr(Selected.Geographies, 6, 10))

blockrace<-merge(shapevect, pum8, by="PUMACE10")

blockrace$blockarea<-expanse(blockrace, unit="m")

blockracedf<-as.data.frame(blockrace)

summary(blockracedf)

#intersect puma with stations
buffdf <- as.data.frame(buff)

output2<-c()

for(i in 0:24){
  print(i)
  buff2 <-subset(buff, buff$FID ==i)
  int<-crop(blockrace, buff2)
  int$intarea<-expanse(int, unit="m")
  intdf<-as.data.frame(int) %>%
    mutate(frac_area=intarea/blockarea) %>%
    mutate(Total=Total*frac_area, 
           Car.truck.van=Car.truck.van*frac_area,
           Bus.or.trolley.bus = Bus.or.trolley.bus*frac_area,
           Streetcar.or.trolley.car=Streetcar.or.trolley.car*frac_area,
           Subway.or.elevated=Subway.or.elevated*frac_area,
           Railroad=Railroad*frac_area,
           Ferry.boat=Ferry.boat*frac_area,
           Taxicab=Taxicab*frac_area,
           Motorcycle=Motorcycle*frac_area,
           Bicycle=Bicycle*frac_area,
           Walked=Walked*frac_area,
           Worked.At.Home=Worked.At.Home*frac_area,
           Other=Other*frac_area)|>
    summarize(Total08=sum(Total), 
              Car.truck.van08=sum(Car.truck.van),
              Bus.or.trolley.bus08=sum(Bus.or.trolley.bus),
              Streetcar.or.trolley.car08=sum(Streetcar.or.trolley.car),
              Subway.or.elevated08=sum(Subway.or.elevated),
              Railroad08=sum(Railroad),
              Ferry.boat08=sum(Ferry.boat),
              Taxicab08=sum(Taxicab),
              Motorcycle08=sum(Motorcycle),
              Bicycle08=sum(Bicycle),
              Walked08=sum(Walked),
              Worked.At.Home08=sum(Worked.At.Home),
              Other08=sum(Other)) %>%
    mutate(pct_Car.truck.van08=Car.truck.van08*100/Total08,
           pct_Bus.or.trolley.bus08=Bus.or.trolley.bus08*100/Total08,
           pct_Streetcar.or.trolley.car08=Streetcar.or.trolley.car08*100/Total08,
           pct_Subway.or.elevated08=Subway.or.elevated08*100/Total08,
           pct_Railroad08=Railroad08*100/Total08,
           pct_Ferry.boat08=Ferry.boat08*100/Total08,
           pct_Taxicab08=Taxicab08*100/Total08,
           pct_Motorcycle08=Motorcycle08*100/Total08,
           pct_Bicycle08=Bicycle08*100/Total08,
           pct_Walked08=Walked08*100/Total08,
           pct_Worked.At.Home08=Worked.At.Home08*100/Total08,
           pct_Other08=Other08*100/Total08) %>%
    mutate(FID=i)
  
  output2<-rbind(output2, intdf)
}

#combine data from 2008 and 2004
output3<-merge(output, output2, by="FID")

#Sum_demog
alldf<-cbind(output3, coef)

# Demog data with station level PM2.5
reddf <- alldf %>%
  mutate(Total_change=Total*coef,
         Car.truck.van_change = Car.truck.van*coef,
         Bus.or.trolley.bus_change=Bus.or.trolley.bus*coef,
         Subway.or.elevated_change=Subway.or.elevated*coef,
         Railroad_change=Railroad*coef,
         Ferry.boat_change=Ferry.boat*coef,
         Taxicab_change=Taxicab*coef,
         Motorcycle_change=Motorcycle*coef,
         Bicycle_change=Bicycle*coef,
         Walked_change=Walked*coef,
         Worked.At.Home_change=Worked.At.Home*coef,
         Other_change=Other*coef,
         Total08_change=Total08*coef,
         Car.truck.van08_change = Car.truck.van08*coef,
         Bus.or.trolley.bus08_change=Bus.or.trolley.bus08*coef,
         Subway.or.elevated08_change=Subway.or.elevated08*coef,
         Railroad08_change=Railroad08*coef,
         Ferry.boat08_change=Ferry.boat08*coef,
         Taxicab08_change=Taxicab08*coef,
         Motorcycle08_change=Motorcycle08*coef,
         Bicycle08_change=Bicycle08*coef,
         Walked08_change=Walked08*coef,
         Worked.At.Home08_change=Worked.At.Home08*coef,
         Other08_change=Other08*coef)%>%
  summarize(Total_change_sum=sum(Total_change),
            Car.truck.van_change_sum=sum(Car.truck.van_change),
            Bus.or.trolley.bus_change_sum=sum(Bus.or.trolley.bus_change),
            Subway.or.elevated_change_sum=sum(Subway.or.elevated_change),
            Railroad_change_sum=sum(Railroad_change),
            Ferry.boat_change_sum=sum(Ferry.boat_change),
            Taxicab_change_sum=sum(Taxicab_change),
            Motorcycle_change_sum=sum(Motorcycle_change),
            Bicycle_change_sum=sum(Bicycle_change),
            Walked_change_sum=sum(Walked_change),
            Other_change_sum=sum(Other_change),
            Total08_change_sum=sum(Total08_change),
            Car.truck.van08_change_sum=sum(Car.truck.van08_change),
            Bus.or.trolley.bus08_change_sum=sum(Bus.or.trolley.bus08_change),
            Subway.or.elevated08_change_sum=sum(Subway.or.elevated08_change),
            Railroad08_change_sum=sum(Railroad08_change),
            Ferry.boat08_change_sum=sum(Ferry.boat08_change),
            Taxicab08_change_sum=sum(Taxicab08_change),
            Motorcycle08_change_sum=sum(Motorcycle08_change),
            Bicycle08_change_sum=sum(Bicycle08_change),
            Walked08_change_sum=sum(Walked08_change),
            Other08_change_sum=sum(Other08_change),
            Total = sum(Total),
            Car.truck.van = sum(Car.truck.van),
            Bus.or.trolley.bus = sum(Bus.or.trolley.bus),
            Subway.or.elevated = sum(Subway.or.elevated),
            Railroad = sum(Railroad),
            Ferry.boat = sum(Ferry.boat),
            Taxicab = sum(Taxicab),
            Motorcycle = sum(Motorcycle),
            Bicycle = sum(Bicycle),
            Walked = sum(Walked),
            Other = sum(Other),
            Total08 = sum(Total08),
            Car.truck.van08 = sum(Car.truck.van08),
            Bus.or.trolley.bus08 = sum(Bus.or.trolley.bus08),
            Subway.or.elevated08 = sum(Subway.or.elevated08),
            Railroad08 = sum(Railroad08),
            Ferry.boat08 = sum(Ferry.boat08),
            Taxicab08 = sum(Taxicab08),
            Motorcycle08 = sum(Motorcycle08),
            Bicycle08 = sum(Bicycle08),
            Walked08 = sum(Walked08),
            Other08 = sum(Other08))

%>%
  
  mutate(Total_change_ave=(Total_change_sum*100)/Total,
         Car.truck.van_change_ave=Car.truck.van_change_sum*100/Car.truck.van,
         Bus.or.trolley.bus_change_ave=Bus.or.trolley.bus_change_sum*100/Bus.or.trolley.bus,
         Subway.or.elevated_change_ave=Subway.or.elevated_change_sum*100/Subway.or.elevated,
         Railroad_change_ave=Railroad_change_sum*100/Railroad,
         Ferry.boat_change_ave=Ferry.boat_change_sum*100/Ferry.boat,
         Taxicab_change_ave=Taxicab_change_sum*100/Taxicab,
         Motorcycle_change_ave=Motorcycle_change_sum*100/Motorcycle,
         Bicycle_change_ave=Bicycle_change_sum*100/Bicycle,
         Walked_change_ave=Walked_change_sum*100/Walked,
         Other_change_ave=Other_change_sum*100/Other,
         Total08_change_ave=Total08_change_sum*100/Total08,
         Car.truck.van08_change_ave=Car.truck.van08_change_sum*100/Car.truck.van08,
         Bus.or.trolley.bus08_change_ave=Bus.or.trolley.bus08_change_sum*100/Bus.or.trolley.bus08,
         Subway.or.elevated08_change_ave=Subway.or.elevated08_change_sum*100/Subway.or.elevated08,
         Railroad08_change_ave=Railroad08_change_sum*100/Railroad08,
         Ferry.boat08_change_ave=Ferry.boat08_change_sum*100/Ferry.boat08,
         Taxicab08_change_ave=Taxicab08_change_sum*100/Taxicab08,
         Motorcycle08_change_ave=Motorcycle08_change_sum*100/Motorcycle08,
         Bicycle08_change_ave=Bicycle08_change_sum*100/Bicycle08,
         Walked08_change_ave=Walked08_change_sum*100/Walked08,
         Other08_change_ave=Other08_change_sum*100/Other08)

#display results
change04<-reddf[,44:55] 
change08<-reddf[,56:66]

kable(reddf, digits=2)
