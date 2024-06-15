library("terra")
library("tidyverse")

#makes of list of files in that folder
files<-dir("G:/Shared drives/2024 FIRE Light Rail/DATA/GLDAS/")

sta<-vect("buff_sta.shp")
days_output<-c()
for (d in 1955:3288) {
  print(files[d])
r<-rast(paste0("G:/Shared drives/2024 FIRE Light Rail/DATA/GLDAS/", files[d]))

#names(r)
#variables in page 19 of manual
#https://hydro1.gesdisc.eosdis.nasa.gov/data/GLDAS/GLDAS_CLSM025_D.2.0/doc/README_GLDAS2.pdf
#Snowf_tavg<-r[[6]]
#plot(Snowf_tavg)

#crops raster to contain only buffers around stations
int<-crop(r, sta,
          snap="in",
          mask=TRUE)
#plot(int)

#convert cropped raster into dataframe and find average value
metdf<-terra::extract(int, sta, fun="mean", na.rm=TRUE)  %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%
  select(-ID)

metdf$date<-files[d]
#combine output with previous looop
days_output<-rbind(days_output, metdf)

}
#create .csv file for each month
write.csv(days_output,
          paste0("Met_sta_daily/met_",
                 ".csv")
          , row.names = F)
