library("terra")

buff<-vect("buff_sta.shp") #stations shapefile

#get puma shapefile
library('sp')
library('tigris')
shape<-tigris::pumas(state="TX",class="sp", year=2012)
shapevect<-vect(shape)
shapedf<-as.data.frame(shape)

#clean puma data for 2004
pum4<-read.csv("puma2004.csv") |>
  mutate(PUMACE10=substr(Selected.Geographies, 6, 10))

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
