library("terra")

r<-terra::vect("tl_2021_txharris_roads/tl_2021_48201_roads.shp")

rdf<-as.data.frame(r)

tsp<-subset(r, r$FULLNAME=="Katy Fwy")
terra::plot(tsp)

l