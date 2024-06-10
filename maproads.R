library("terra")

r<-terra::vect("tl_2021_txharris_roads/tl_2021_48201_roads.shp")

rdf<-as.data.frame(r)

tsp<-subset(r, r$FULLNAME=="N Loop W Svc Rd" | r$FULLNAME == "Southwest Fwy" | r$FULLNAME == "Katy Fwy" | r$FULLNAME == "S Loop W Svc Rd" | r$FULLNAME == "W Loop S Fwy" | r$FULLNAME == "W Loop S Svc Rd" | r$FULLNAME == "Gulf Fwy" | r$FULLNAME == "North Fwy" | r$FULLNAME == "N Loop E Fwy" | r$FULLNAME == "N Loop E Svc Rd" | r$FULLNAME == "South Fwy")
tsp_df <- as.data.frame(tsp)
terra::plot(tsp)
r
l
#N Loop W Svc Rd
#Southwest Fwy
#Katy Fwy
#S Loop W Svc Rd
#W Loop S Fwy
#W Loop S Svc Rd
#Gulf Fwy
#North Fwy
#N Loop E Fwy
#N Loop E Svc Rd

