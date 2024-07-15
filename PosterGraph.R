df3 <- read.csv('regression_analysis_data') 

df4<-df3 %>%
  group_by(date, MetroOpen) %>%
  summarize(PM25=mean(pm25)) %>%
  mutate(date=as.Date(date), MetroOpen=as.factor(MetroOpen)) 

TERPstart <- as.Date('2001-11-14', format = '%Y-%m-%d')
TERPinactive <- as.Date('2002-2-1', format = '%Y-%m-%d')
TERPreactive <- as.Date('2003-6-26', format = '%Y-%m-%d')
endDate <- as.Date('2008-12-31', format = '%Y-%m-%d')

ggplot(data=df4, aes(x=date, y=PM25, col=MetroOpen))+
  geom_point()+
  annotate(geom='rect',xmin=TERPstart,xmax=TERPinactive,ymin=0,ymax=100, fill ='grey', alpha = .5)+
  annotate(geom='text', x = TERPstart+55, y= 101, label = 'TERP')+
  annotate(geom='rect', xmin=TERPreactive, xmax=endDate, ymin=0, ymax = 100, fil = 'grey', alpha = 0.2)+
  annotate(geom='text', x = TERPreactive+365+365+180, y= 101, label = 'TERP')
 # geom_rect(aes(xmin=TERPstart,xmax=TERPinactive, ymin=0, ymax=100), alpha = 0.01, fill = 'grey')+
  #scale_color_manual(values=pal[3:4])+
 # geom_rect(aes(xmin=TERPreactive,xmax=endDate, ymin=0, ymax = 100), alpha = 0.01, fill = 'grey')

