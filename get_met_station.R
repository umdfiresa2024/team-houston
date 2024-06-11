library("terra")
library("tidyverse")

#makes of list of files in that folder
files<-dir("G:/Shared drives/2024 FIRE Light Rail/DATA/GLDAS/")

i<-1

r<-rast(paste0("G:/Shared drives/2024 FIRE Light Rail/DATA/GLDAS/", files[i]))

names(r)
#variables in page 19 of manual
#https://hydro1.gesdisc.eosdis.nasa.gov/data/GLDAS/GLDAS_CLSM025_D.2.0/doc/README_GLDAS2.pdf
#Snowf_tavg<-r[[6]]
#plot(Snowf_tavg)

sta<-vect("buff_sta.shp")

#crops raster to contain only buffers around stations
int<-crop(r, sta,
          snap="in",
          mask=TRUE)
plot(int)

#convert cropped raster into dataframe and fine average value
metdf<-terra::extract(int, sta, fun="mean", na.rm=TRUE)  %>% 
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%
  select(-ID)

metdf$date<-files[i]
