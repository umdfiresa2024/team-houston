df3 <- read.csv('regression_analysis_data') 

df4<-df3 %>%
  group_by(date, MetroOpen) %>%
  summarize(PM25=mean(pm25)) %>%
  mutate(date=as.Date(date), MetroOpen=as.factor(MetroOpen)) 

TERPstart <- as.Date('2001-11-14', format = '%Y-%m-%d')
TERPinactive <- as.Date('2002-2-1', format = '%Y-%m-%d')
TERPreactive <- as.Date('2003-6-26', format = '%Y-%m-%d')
endDate <- as.Date('2008-12-31', format = '%Y-%m-%d')

library("RColorBrewer")

display.brewer.pal(n=8, name="RdYlGn")
pal<-brewer.pal(n=8, name="RdYlGn")
pal2<-c(pal[1],pal[8])

ggplot(data=df4, aes(x=date, y=PM25, col=MetroOpen))+
  geom_point(size=0.25)+
  annotate(geom='rect',xmin=TERPstart,xmax=TERPinactive,ymin=0,ymax=100, fill ='grey', alpha = .5)+
  annotate(geom='text', x = TERPstart+55, y= 101, label = 'TERP', size = 3)+
  annotate(geom='rect', xmin=TERPreactive, xmax=endDate, ymin=0, ymax = 100, fill = 'grey', alpha = 0.2)+
  annotate(geom='text', x = TERPreactive+365+365+180, y= 101, label = 'TERP', size = 3)+
  theme(axis.text=element_text(size = 25),
        axis.title = element_text(size = 35),
        legend.text = element_text(size = 25),
        legend.title = element_text(size = 35))+
  labs(x='Date',y='PM 2.5 (ug/m3)')+
  theme_bw()+
  scale_color_manual(values=pal2)

ggsave("poster_graph.png", dpi=300, width=7, height=2, unit="in")
 # geom_rect(aes(xmin=TERPstart,xmax=TERPinactive, ymin=0, ymax=100), alpha = 0.01, fill = 'grey')+
  #scale_color_manual(values=pal[3:4])+
 # geom_rect(aes(xmin=TERPreactive,xmax=endDate, ymin=0, ymax = 100), alpha = 0.01, fill = 'grey')

