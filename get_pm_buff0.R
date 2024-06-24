# get pm2.5 data for one month
install.packages('terra')
install.packages('tidyverse')
library('terra')
library('tidyverse')

buff_sta_shp <- vect("buff_sta.shp")

path<-"G:/Shared drives/2024 FIRE Light Rail/DATA/PM25/"
months<-dir(path) #makes a vector of folder names

# for each month

#for (m in 1:length(months)) {
for (m in 68:length(months)) {
  print(months[m])
  days<-dir(paste0(path,months[m])) #makes a vector of filenames within each folder
  
  # for each day in this month
  
  days_output<-c()
  for (d in 1:length(days)) {
    

    print(days[d])
    
    #read tif file
    r<-rast(paste0(path, months[m], "/", days[d]))
    
    #changes the crs system
    buff_project <- terra::project(buff_sta_shp,  crs(r))
    
    #Isolated just the 1st buffer
    buff0 <- subset(buff_project, buff_project$FID == 0)
    
    #pts_buffer is the buffer around stations
    #crops raster to contain only buffers around stations
    int<-crop(r, buff0,
              snap="in",
              mask=TRUE)
    
    #convert cropped raster into dataframe and fine average value
    cntrl_df<-terra::extract(int, buff0, fun="mean", na.rm=TRUE)
    
    #rename columns
    names(cntrl_df)<-c("city_num","pm25")
    
    #create a dataframe date, shape index, and pm25
    output <- as.data.frame(c("date"=days[d], cntrl_df))
    
    #combine output with previous looop
    days_output<-rbind(days_output, output)

    
  }
  
  #create .csv file for each month
  write.csv(days_output,
            paste0("PM25_daily/buff0_",
                   months[m],
                   ".csv")
            , row.names = F)
  
}
