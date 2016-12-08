library(data.table)
library(ggplot2)
library(ggthemes)


### Example "theme"-- you can modify all the formatting in this theme below, then apply the theme to your plots.

# Defining the ggplot2 theme() theme_wpal() to use with base maps-----------------------------------------
theme_wpal<- function(base_size=14, base_family="sans",map=TRUE,legend_position="bottom",legend_direction="horizontal") {
  print("If you use this for a map, you must add coord_fixed() to your plot!")
  ((theme_foundation(base_size=base_size, base_family=base_family)+theme(
    
    # Titles and text----------------------------------------------------------
    
    plot.title = element_text(face = "plain", size = rel(1.2), hjust = 0.5),
    text = element_text(),
    panel.background = element_rect(colour = NA),
    plot.background = element_rect(colour = NA),
    panel.border = element_rect(colour = NA),
    # Panel outlines
    panel.grid.major = element_blank(),#element_line(colour="#f0f0f0"),
    panel.grid.minor = element_blank(),
    
    # Legends----------------------------------------------------------------
    legend.key = element_rect(colour = NA),
    legend.position = legend_position,
    legend.direction = legend_direction,
    legend.key.size= unit(0.4, "cm"),
    legend.margin = unit(0, "cm"),
    legend.title = element_text(face="plain"),
    
    # Margins----------------------------------------------------------------
    plot.margin=unit(c(10,5,5,5),"mm"),
    strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
    strip.text = element_text(face="bold")))+
     
     # Adding Axis labels (map specific or no):--------------------------------
   if(map){
     theme(
       axis.title =element_blank(),
       axis.title.y = element_blank(),
       axis.title.x =element_blank(),
       axis.text = element_blank(),
       axis.line = element_blank(),
       axis.ticks = element_blank())
   }else{
     theme(
       axis.title = element_text(face = "bold",size = rel(1)),
       axis.title.y = element_text(angle=90,vjust =2),
       axis.title.x = element_text(vjust = -0.2),
       axis.text = element_text(), 
       axis.line = element_line(colour="black"),
       axis.ticks = element_line())
   }
  ) # Closing the theme() object
}# Closing theme_wmap() function

###########################
# Making your heatmap
##########################

relevant_data<-fread("full_csv_file_path")

# Simulating a data set:
example<-data.table(CJ(c("apple","pear","orange"),c("1","2","3")))
example[,simulated_var:=rnorm(nrow(example),0)]
example[,fruit:=as.factor(V1)]

#xvar and yvar should both be factors, while fillvar should be numeric.

heat_map<-ggplot(data=example,
       aes(x = fruit, y = V2, fill = simulated_var))+
       geom_tile()+ # This is what makes it a heat map
  theme_wpal(legend_position="top",base_size=20,map=F)+
  scale_fill_gradientn(colours=c("red","yellow","green"))+
  geom_text(aes(label = round(simulated_var, 1)),colour="black")+
  guides(fill=guide_colourbar(title="Value", barheight=1, barwidth=10, label=TRUE, ticks=FALSE ))
  

print(heat_map)
  

  
