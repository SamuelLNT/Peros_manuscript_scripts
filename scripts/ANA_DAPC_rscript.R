library('adegenet')
#setwd("$PATH")
setwd("$PATH")

data <- read.structure("STRUCTURE_Eros_REF_aftrkr_merg_n55_c85_m35.ustr.str", n.ind=55, n.loc=82275, onerowperind=FALSE, col.lab=1, col.pop=0, col.others=NULL, row.marknames=FALSE, NA.char="-9", pop=NULL, ask=FALSE, quiet=FALSE)
prefix="Eros_REF_icarus_n55_m35"

# scale genetic data for PCA (scaling to missing data)
data_scaled <- scaleGen(data, center=FALSE, scale=FALSE, NA.method=c("zero"), nf)

# PCA, can adjust nf to include more components
pca1 <- dudi.pca(data_scaled, center=TRUE, scale=TRUE, scannf=FALSE, nf=2) #nf=number of dimention
plot(pca1$li, xlab="Scaling Dimension 1", ylab="Scaling Dimension 2", main=paste(prefix,"PCA", sep="_"), pch=16)
s.label(pca1$li, clabel=0.5, grid=0)

# DAPC, determine optimal number of genetic clusters
# set max.n.clust to maximum number of pops
clusters <- find.clusters(data, max.n.clust=9, n.iter=1e6)

#print out the BIC reading for each k value
head(clusters$Kstat)
write.csv(clusters$Kstat, file=paste(prefix,"clusters_BIC",".csv", sep=""))

#Rewriting group name
clusters$grp <- edit(clusters$grp)

grp_k <- nlevels(clusters$grp)
results <- dapc(data, clusters$grp, perc.pca=NULL)

assignplot(results,)
compoplot(results, show.lab = FALSE)

#visualising DAPC results
scatter(results) #DAPC plot
legend("topleft",                    # Add legend to plot
       legend = c(levels(results$grp)),
       col = 1:2,
       pch = 16)
DAPC.grp.out <- data.frame(sampleID=c(row.names(results$tab)), DAPC.groups=c(results$grp))
write.csv(DAPC.grp.out,file = paste("DAPC_grp_out_",prefix,".csv", sep=""))


#///////////////////////////////////////////////////////////////////////////////
## Modified from https://luisdva.github.io/rstats/dapc-plot/
# Load libraries. Install first if needeed
library(readxl)    # CRAN v1.3.1
library(janitor)   # CRAN v2.1.0
library(dplyr)     # CRAN v1.0.7
library(tidyr)     # CRAN v1.1.3
library(ggplot2)   # CRAN v3.3.5
library(forcats)   # CRAN v0.5.1
library(stringr)   # CRAN v1.4.0
library(ggh4x)     # [github::teunbrand/ggh4x] v0.2.0.9000
library(paletteer) # CRAN v1.4.0
library(extrafont) # CRAN v0.17

gps <- read.csv("eros_coordinates.csv")
colnames(gps)

#for Hipparchia coordinates
#colnames(gps) <- c("voucher", "Genus", "species","ind","country", "sampleID1","ddRADCode")
#gps_sub<-gps[ , c("ind", "species", "country")]

#for other standard RAD case
colnames(gps) <- c("ind","sample.ID","genus","species","country","region","lat","lon")
gps_sub<-gps[ , c("ind", "species", "country")]

# create an object with membership probabilities
postprobs <- as.data.frame(round(results$posterior, 4))
head(postprobs)
write.csv(postprobs, file=paste("DAPC_postprob_out_",prefix,".csv", sep=""))
# put probabilities in a tibble with IDS and labels for sites
resultclusters <- tibble::rownames_to_column(postprobs, var = "ind")# %>% mutate(species = eros.gps$Species, loc=eros.gps$Country)
resultclusters$ind <- str_sub(resultclusters$ind, end=-5)
resultclusters<- left_join(resultclusters,gps_sub,by="ind")
head(resultclusters)

# melt into long format
result_long <- resultclusters %>% pivot_longer(2:(grp_k+1), names_to = "cluster", values_to = "prob")
head(result_long)
# manual relevel of the sampling sites (to avoid alphabetical ordering)
unique(result_long$species)
country <- unique(result_long$country)
##Not needed line: esult_long <- result_long %>% arrange(species, loc)
result_long$country <- fct_relevel(as.factor(result_long$country), sort(country))


result_long$species <- fct_relevel(as.factor(result_long$species), "eroides","boisduvalii","eros","menelaos","italica")
write.csv(result_long, file="view.csv")
# column for the municipality abbreviation
#following line  muted because of better understanding
#result_long <- result_long %>% mutate(species = )

facetstrips <- strip_nested(
  text_x = elem_list_text(size = c(10, 4)),
  by_layer_x = TRUE, clip = "off"
)



ggplot(result_long, aes(factor(ind), prob, fill = factor(cluster))) +
  geom_col(color = "gray", size = 0.01) +
  facet_nested(~ country + species,
               switch = "x",
               nest_line = element_line(size = 1, lineend = "round"),
               scales = "free", space = "free", strip = facetstrips
  ) +
  #theme_minimal(base_family = "Nimbus Sans") +
  labs(x = "Individuals", y = "membership probability") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_discrete(expand = expansion(add = 0.5)) +
  #scale_fill_manual(values = c("grey","darkgreen","orange"))+ #to change colour :D
  guides(fill=guide_legend(title="DAPC Clusters"))+ #this is to change the colour legend
  scale_fill_paletteer_d("lisa::OskarSchlemmer", guide = "none", direction = 1) +
  #scale_fill_hue(h = c(180, 300))
  theme(
    panel.spacing.x = unit(0.18, "lines"),
    axis.text.x = element_blank(),
    panel.grid = element_blank(),
    strip.text.x= (element_text(angle=90, hjust=0, vjust=0, size = 8,)), #rotated vertical
    
    )


ggsave("plot.svg", width = 10, height = 4)

######Drawing graph according to tree
topo <- read.csv("n55_m35_treetopology.csv")
colnames(topo) <- c("ind","topo_order","group","case")
result_long <- left_join(result_long,topo,by="ind")
result_long <- result_long[order(result_long$topo_order),]
result_long$order_ind <- paste(result_long$topo_order,result_long$ind,sep="_")
ggplot(result_long, aes(factor(order_ind, levels = unique(order_ind)), prob, fill = factor(cluster))) +
  geom_col(color = "gray", size = 0.01) +
  labs(x = "Individuals", y = "membership probability") +
  scale_y_continuous(expand = c(0, 0)) +
  theme(
    panel.spacing.x = unit(0.18, "lines"),
    axis.text.x = (element_text(angle=90, size = 8,)),
    panel.grid = element_blank(),
      )
ggsave("topo_plot.svg", width = 10, height = 4)

#///////////////////////////////////////////////////////////////////////////////


# PCA with DAPC groupings
eig.perc <- 100*pca1$eig/sum(pca1$eig) #Explainations for each PC
##ggplot for pca
ggplot(pca1$li, aes(x=Axis1, y=Axis2, color = clusters$grp)) + 
  geom_point()+
  guides(color=guide_legend(title="cluster"))+
  scale_fill_manual(values = c("grey","darkgreen","orange"))+
  labs(tittle="DAPC coupled PCA plot", x="PC1", y="PC2")+
  theme_light()
ggsave(paste(prefix,"_DAPC_PCA.svg",sep=""), width = 5, height = 5)

#simple plot for PCA
plot(pca1$li, xlab="Scaling Dimension 1", ylab="Scaling Dimension 2", main="PCA with DAPC clusters", col=clusters$grp, pch=16)
s.label(pca1$li, clabel=0.5, grid=0)



