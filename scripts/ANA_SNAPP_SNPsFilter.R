#Using phylip file input

#setwd("$PATH")
setwd("$PATH")
library(ape)
library(bioseq)

################# MAIN SCRIPT ###########################
prefix <- "reduced_n28_REF_icarus_n55_m35"

dna_bin<- read.dna("reduced_n28_REF_icaurs_n55_m35.usnps.phy", format = "sequential")
dna_bin

#get the species
#my species name format is [1 letter from genus][4 lettees from species]_[CODE]_[CountryCode]
#hence if it is Agriades aquilo RV2400420 from Finland, then it will be Aaqui_RV2400420_FI
spp.name <- unique(substr(row.names(dna_bin),1,5))
spp.name

#Reset all variables
out <- data.frame(sp="NA", site="NA")
out <- out[-1,]
i=1
j=1

#compare all sites if any of the columns in the subset are only having "N"s, 
  #it will write down to the "out" dataframe
#the value of each base can be found: 
  #http://ape-package.ird.fr/misc/BitLevelCodingScheme_20April2007.pdf
  #A=136; G=72; C=40; T=24; R=192; M=160; W=144; S=96; K=80; Y=48; 
  #V=224; H=176; D=208; B=112; N=240; - (Alignment gap)=4; ? (Unknown character)=2
for (i in 1:length(spp.name)){
  seq <- dna_bin[grepl(spp.name[i], rownames(dna_bin)), ] #create subset of alignment for each species
  for (j in 1:length(dna_bin[1,])){
    if(sum(seq[,j]==240)==nrow(seq)){
      out <- rbind(out, data.frame(sp=c(spp.name[i]), site=j))
    }
  }
}


#processing the table containing all the missing sites across different species
missing.site <- unique(out$site) #remove the first row because that is empty when we fist create a blank dataset
length(missing.site) #print out the number of sites to be removed, compare it to SNAPP run
missing.site <- sort(as.numeric(missing.site)) #sort the missing sites in order, just for human to read

dna_bin <- dna_bin[,-missing.site] #remove the missing sites in the alignment
dna_bin

#You can skip this line to write out a phylip file, because it will not be used in following script as well...
write.dna(dna_bin, paste(prefix,"_WOmissingsies.usnps.phy",sep=""), format="sequential", nbcol=-1, colsep="")

#////////////// Below, we will convert the output to nexus by package phrynomics////////
library(phrynomics)

#turning the dnabin to things can read by phyrnomics
snps <- as_tibble.DNAbin(dna_bin, label="label")[,-1] #just to retain the table with sequence only, because the tibble itself cant be load by ReadSNP function
row.names(snps) <- rownames(dna_bin) 
str(snps)
row.names(snps)
snps <- ReadSNP(snps)

#checking the data
GetSpecies(rownames(snps$data))
GetNumberOfSitesForLocus(snps)
MakeMinIndTable(snps, showEvery=1)
#snps.binary <- TranslateBases(snps, translateMissingChar="?", ordered=TRUE) #muted this line for i was testing the things

#actually filtering
#snps<-RemoveInvariantSites(snps) #I dont know if this is good...
snps.binary <- RemoveNonBinary(snps) #retain only the binary sites (you can try and see how it changes the matrix)
GetNumberOfSitesForLocus(snps.binary)
snps.binary <- TranslateBases(snps.binary, translateMissingChar="?", ordered=TRUE)
GetSpecies(rownames(snps.binary$data))
GetNumberOfSitesForLocus(snps.binary) #just to see how many sites remain

#writing output
WriteSNP(snps.binary, file=paste(prefix,"_phyromics_rmnonbinary_formated.phy",sep=""), format="phylip", missing="?")
WriteSNP(snps.binary, file=paste(prefix,"_phyromics_rmnonbinary_formated.nex",sep=""), format="nexus", missing="?")



