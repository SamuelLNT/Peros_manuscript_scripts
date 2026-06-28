###########
#This is the script to plot the pie chart to the coordinate correctly.
###########


#setwd("$PATH")
#setwd("$PATH")
#setwd("$PATH")
#setwd("$PATH")
#setwd("$PATH")

setwd("$PATH")

library(dplyr)
library(stringr)

#Data preparation
header <- "Pyrgus_REF_n51_m26"
qmat_ori <- read.table("K2_ClumppIndFile.output", sep="") 
head(qmat_ori)
tail(qmat_ori)
rm(j)
print("State the number of samples")
i=length(unique(qmat_ori$V1))

print("Select K number:")
j=(ncol(qmat_ori)-5)


#rename header for indfile
colnames(qmat_ori) <- c("#","str.code","Missing.loci","pop", "sep","k1","k2")

#extract names and order for str
str_name<- read.table("Pyrgus_REF_n51_m26_c85_INGR.ustr.str")[,1:2]
colnames(str_name) <- c("init","pop")
str_name<-distinct(str_name)
str_name$init <- str_sub(str_name$init, end=-3) #Remove the tail of the str name ie _U / _U_M
t <- sort(rep(c(1:i)))##change the end number depends on number of samples
str_name$str.code <- c(t)
head(str_name)

#Calculating the start and end of rows
print("Select the position of the best run:")
k=1

print("Staring row:")
n<-(i*(k-1))+1
print("end row:")
m<-i*k
j<- j+6-1

#Extracting runs from indfile
rm("qmat")
qmat <- qmat_ori[n:m,c(1,2,4,6:j)] #change the start and end according to the calvulation above.
head(qmat)


#final check for the files
str(str_name)
str(qmat)

##merging the q matrix with str.id
qmat<- right_join(qmat, str_name, by="str.code")
head(qmat)

write.csv(qmat, file= paste(header,"_out.csv", sep=""))

gps<-read.csv("Pyrgus_GPS_Group.csv")
colnames(gps)
qmat<-left_join(qmat, gps, by="init")
head(qmat)


##============CODE FOR PLOTTING=========
##source:https://www.molecularecologist.com/2014/11/13/admixture-maps-in-r-for-dummies/
library(maps)
library(mapdata)
library(plotrix)
library(mapproj)
##gps<-read.csv(??gps.data??,header=TRUE) #Read input files
##admix<-read.csv(??admixprops.data??,header=TRUE)
number<-paste("K",(ncol(qmat_ori)-5),sep = "")
#svg(filename= paste(number,"_",header,sep = ""))
pdf(file= paste(number,"_",header,".pdf",sep = ""), width=8, height=6,)#this function is still under test

#Agriades xlim = c(-20, 100), ylim = c(35, 71)
  #pyrenaicus xlim = c(-20, 50), ylim = c(38, 53)
#Pyrgus xlim = c(-10,47), ylim = c(32, 57)
  #ContactZoneRO xlim = c(27.4, 28.6), ylim = c(43.8, 44.6)
  #ContactZoneUA xlim = c(35, 39), ylim = c(48, 52)
#eros xlim = c(-10, 42), ylim = c(35, 53)
map(database="world",xlim = c(27, 29), ylim = c(43, 45), col="gray98", fill=TRUE) #Plot maps
#mapproject(50,50, projection = "mercator")
map.scale(60,50, ratio=FALSE, relwidth = 0.5, cex=0.03)
map.axes() #Add axes

#for (x in 1:nrow(qmat)) { radial.pie(qmat$Lon[x],qmat$Lat[x], #You can modify your loop to reflect this
                                #       col=c(
                                #         "red","blue",
                                 #        "yellow","purple")) }

#Adding sample points
points(qmat$Lon, qmat$Lat,
       cex = 0.03, col="red", pch=16)

 #To add just points
#for (x in 2:nrow(qmat)) { #To add arrows for migration models
  #arrows(qmat$Lon[1],qmat$Lat[1],qmat$Lon[x],
         #qmat$Lat[x],lty="dashed",code=2)} #To add admixture plots ?V here I used K = 2.
for (x in 1:nrow(qmat)) { floating.pie(qmat$Lon[x],qmat$Lat[x], #You can modify your loop to reflect this
                                      c(qmat$k1[x],qmat$k2[x],qmat$k3[x],qmat$k4[x],qmat$k5[x],qmat$k6[x]),radius=0.03,
                                      col=c(
                                        "green","orange",
                                        "chocolate","purple","deepskyblue","pink"));
                          pie.labels(qmat$Lon[x],qmat$Lat[x],angles=0,labels=qmat$init[x],minangle = 0,boxed = FALSE)}
#legend("bottomleft", legend=print(1:(ncol(qmat_ori)-5)), pch=16, col=c("green","orange","chocolate","purple","deepskyblue","pink"))


#https://r-graph-gallery.com/colors.html for colour

##Following is for wolbachia points

#points(qmat$Lon, qmat$Lat,
       #cex = 0.5, col=qmat$Wolbachia.group, pch=16)


## usage of float.pie
## floating.pie(xpos=0,ypos=0,x,edges=200,radius=1,col=NULL,startpos=0,
##              shadow=FALSE,shadow.col=c("#ffffff","#cccccc"),explode=0,...)
dev.off()

#===========Making maps from other source====
#source: https://www.r-bloggers.com/2019/04/zooming-in-on-maps-with-sf-and-ggplot2/
library(ggplot2)
library(sf)
library(rnaturalearth) ##maps here are in WGS84
worldmaps <- ne_countries(scale = 'medium', type = 'map_units',
                         returnclass = 'sf')
# have a look at these two columns only
head(worldmaps[c('name', 'continent')])

ggplot() + geom_sf(data = worldmap) + theme_bw()

#Plotting a european
##Standard European maps for project
##europe_cropped <- st_crop(worldmap, xmin = -20, xmax = 80,ymin = 30, ymax = 73)

#eros project coordinates
##eros_cropped<- st_crop(worldmap, xmin = -20, xmax = 80, ymin = 30, ymax = 60)
##ggplot() + geom_sf(data = europe_cropped) + theme_bw()

ggplot() + geom_sf(data = worldmap) +
  coord_sf(xlim = c(-20, 80), ylim = c(30, 60), expand = FALSE) +
  theme_bw()

###==================Reference===============
library(sf)
library(tidyr)
library(dplyr)
library(ggplot2)
library(cowplot)


states        <- sf::st_as_sf(maps::map("state", plot = FALSE, fill = TRUE))
state_coords <- st_coordinates(st_centroid(states)) %>%
  data.frame(stringsAsFactors = FALSE) %>%
  mutate(ID = states$ID) %>%
  mutate(X = (abs(abs(X) - abs(st_bbox(states)$xmin)) /
                as.numeric(abs(st_bbox(states)$xmin) - abs(st_bbox(states)$xmax))) - 0.5,
         Y = abs(abs(abs(Y) - abs(st_bbox(states)$ymin)) /
                   as.numeric(abs(st_bbox(states)$ymin) - abs(st_bbox(states)$ymax))
         ))

dt     <- data.frame(Territory = c(1, 2, 3, 4, 5),
                     ID = c("california", "wyoming", "new york",
                            "kansas", "georgia"),
                     pins = c(25, 45, 45, 60, 75),
                     oak = c(45, 50, 45, 20, 15),
                     land = c(30, 5, 10, 20, 10))
res <- tidyr::gather(dt, key = "key", value = "value", -Territory, -ID) %>%
  left_join(state_coords)

make_pie <- function(dt, title = NA, legend.position = 0){
  if(is.na(title)){
    title <- unique(dt$ID)
  }
  ggplot() +
    geom_bar(data = dt,
             aes(x = "", y = value, fill = key),
             stat = "identity", width = 1) +
    coord_polar("y") +
    theme_void() +
    theme(legend.position = legend.position) +
    ggtitle(title)
}

terr1 <- make_pie(dplyr::filter(res, Territory == 1))
terr2 <- make_pie(dplyr::filter(res, Territory == 2))
terr3 <- make_pie(dplyr::filter(res, Territory == 3))
terr4 <- make_pie(dplyr::filter(res, Territory == 4))
terr5 <- make_pie(dplyr::filter(res, Territory == 5))

(gg_states <- ggplot(data = states) +
    geom_sf() +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0 )) +
    theme(legend.position = 0,
          plot.margin = unit(c(0,0,0,0), "cm"))
)

leg <- get_legend(make_pie(res, "", legend.position = "left"))

draw_plot_loc <- function(plot, dt){
  draw_plot(plot, x = dt$X[1], y = dt$Y[1],
            height = 0.2)
}

(all <-
    ggdraw(gg_states) +
    draw_plot_loc(terr1, dplyr::filter(res, Territory == 1)) +
    draw_plot_loc(terr2, dplyr::filter(res, Territory == 2)) +
    draw_plot_loc(terr3, dplyr::filter(res, Territory == 3)) +
    draw_plot_loc(terr4, dplyr::filter(res, Territory == 4)) +
    draw_plot_loc(terr5, dplyr::filter(res, Territory == 5))
)

cowplot::plot_grid(all, leg, rel_widths = c(1, 0.1))
