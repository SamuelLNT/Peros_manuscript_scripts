
# STRUCTURE bar plot to match the tree ------------------------------------------------
setwd("C:\\Users\\samue\\OneDrive - Oulun yliopisto\\003_GIS\\eros\\kmlfiles_icarusREF")
#setwd("/Users/samuel_ntl/Library/CloudStorage/OneDrive-Oulunyliopisto/003_GIS/eros/kmlfiles_icarusREF/")

library(ggplot2)
library(dplyr)
library(stringr)
library(tidyr)


#reading the topology information prepared prior
topo <- read.csv("REF_icarus_n55_m35_treetopology.csv")
colnames(topo) <- c("init","topo_order","group","case")

#reading structure file
header <- "RmOGrp_Eros_REF_icarus_n55_m35_STRUCTURE.output"
qmat_ori <- read.table("RmOGrp_Eros_REF_icarus_n55_m35_STRUCTURE.output", sep="") 
head(qmat_ori)
tail(qmat_ori)
rm(j)
print("State the number of samples")
i=length(unique(qmat_ori$V1))
print(i)

print("Select K number:")
j=(ncol(qmat_ori)-5)
print(j)


#rename header for indfile
colnames(qmat_ori) <- c("#","str.code","Missing.loci","pop", "sep","k1","k2", "k3","k4","k5","k6")

#extract names and order for str
str_name<- read.table("RmOgrp_pop_Eros_REF_icarus_aftrkr_merg_n55_c85_m35.ustr.str")[,1:2]
colnames(str_name) <- c("init","pop")
str_name<-distinct(str_name)
str_name$init <- str_sub(str_name$init, end=-5) #Remove the tail of the str name ie _U / _U_M
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

qmat<-left_join(qmat, topo, by="init")
head(qmat)

qmat <- qmat[,c("init","str.code","topo_order","group","case","k1","k2","k3","k4","k5","k6")]
qmat <- qmat[order(qmat$topo_order),]
qmat$init <- paste(qmat$topo_order,qmat$init,sep = "_")
head(qmat)

#rearraging data format
qmat <- qmat |>
  pivot_longer(cols = starts_with("k"), names_to = "population",names_prefix = "k", values_to = "value")

plot <- qmat |> mutate(init = factor(init, levels = unique(str_sort(qmat$init, numeric = TRUE)))) |>
ggplot() + aes(fill=population, y=value, x=init) + 
  geom_bar(position="stack", stat="identity") +
  theme_void()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

plot

#ggsave(filename = paste("STR_TOPO_",header,".pdf",sep=""),plot = plot, path="./")

  