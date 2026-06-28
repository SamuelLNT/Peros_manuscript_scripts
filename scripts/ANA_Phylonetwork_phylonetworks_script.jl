using Pkg
Pkg.add("PhyloPlots")
Pkg.add("PhyloNetworks")
Pkg.add("CSV")
Pkg.add("RCall")
Pkg.add("DataFrames")
Pkg.update()

using RCall # already installed
using PhyloNetworks # already installed
using PhyloPlots # already installed
using CSV # already installed
using DataFrames # already installed



dt = CSV.read("Emedu_alps_separatly_n48_REF.csv",DataFrame)
taxonmap = Dict(dt[i,:specimen] => dt[i,:species] for i in 1:48) # 48 is the number of individuals

raxmltrees = "besttrees.tre"

genetrees = readMultiTopology(raxmltrees)

df_sp = writeTableCF(countquartetsintrees(genetrees, taxonmap)...) # taxon names should be species names, not allele names here

CSV.write("tableCF.csv", df_sp) # to save the data frame to a file
raxmlCF = readTableCF("tableCF.csv") # read in the file and produces a "DataCF" object

astralfile = "Medusa_REF_n48_default_astral.tre"
astraltree = readMultiTopology(astralfile)[1] # read the 1st tree

##Here the rooting is on edge (Agriades heritage)
#rootonedge!(astraltree, 9) ###can be done without outgroup. possibly just silence this line and consequtive rootatnode lines. 
##BUT! if there is only one outgroup, it's better to always root to it.

rootatnode!(astraltree, "Emela")

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('astral_tree_root.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(astraltree, :R, showEdgeLength=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

net0 = snaq!(astraltree,raxmlCF, hmax=0, filename="net0", seed=4353, runs=50)
rootatnode!(net0, "Emela")

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('net0.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(net0, :R, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file


net1 = snaq!(net0, raxmlCF, hmax=1, filename="net1", seed=2345, runs=50)
rootatnode!(net1, "Emela")

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('net1.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(net1, :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

#less("net1.err") # would provide info about errors, if any
#less("net1.out") # main output file with the estimated network from each run
#less("net1.networks") # extra info


net2 = snaq!(net1,raxmlCF, hmax=2, filename="net2", seed=3456, runs=50)
rootatnode!(net2, "Emela")

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('net2.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(net2, :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

#less("net2.err") # would provide info about errors, if any
#less("net2.out") # main output file with the estimated network from each run
#less("net2.networks") # extra info


net3 = snaq!(net2,raxmlCF, hmax=3, filename="net3", seed=4567, runs=50)
rootatnode!(net3, "Emela")

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('net3.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(net3, :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

#less("net3.err") # would provide info about errors, if any
#less("net3.out") # main output file with the estimated network from each run
#less("net3.networks") # extra info


net4 = snaq!(net3,raxmlCF, hmax=4, filename="net4", seed=5567, runs=50)
rootatnode!(net4, "Emela")

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('net4.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(net4, :R, showGamma=true, showEdgeNumber=true); # network is plotted & sent to file
R"dev.off()"; # wrap up and save image file

#less("net4.err") # would provide info about errors, if any
#less("net4.out") # main output file with the estimated network from each run
#less("net4.networks") # extra info




scores = [net0.loglik, net1.loglik, net2.loglik, net3.loglik, net4.loglik] # The best is the (first) one with the lowest value
hmax = collect(0:4)
R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('network_score.svg'), width=6, height=6)" # starts image file
R"par"(mar=[4,4,4,4]) # to reduce margins 
R"plot"(hmax, scores, type="b", ylab="network score", xlab="hmax", col="blue");
R"dev.off()"; # wrap up and save image file


## Here the best network is within net1. Can this network be optimize? Let's do it:

truenet = readTopology("((glandKZ,(aqui,((pyre,dard):2.028139255638847)#H10:0.859094841742487::0.7927476772959192)1:0.06884309861508807)0.71:0.2857301273573,gland,(zull,#H10:8.643961378157723::0.20725232270408078):0.4419475636930522);"); # Tree extracted from net1.networks

net1alt = topologyMaxQPseudolik!(truenet, raxmlCF);

net1alt.loglik

# 0.9831882689607946, same as net1.loglik, so no need for optimization


# Plot the distinct networks contained in net1.networks

file = "net1.networks"

netlist = readMultiTopology(file)


rootonedge!(netlist[1], 6)
R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('bestn1.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[1], :R, showGamma=true, tipOffset=0.1, showEdgeNumber=true);
R"dev.off()"; # wrap up and save image file


rootonedge!(netlist[2], 5)
R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('bestn12.svg'), width=8, height=12)" # starts image file
R"par"(mar=[0,0,0,0]) # to reduce margins (no margins at all here)
plot(netlist[2], :R, showGamma=true, tipOffset=0.1, showEdgeNumber=true) # Second best network
R"dev.off()"; # wrap up and save image file

# Here we obtain that both orbifer_sicily and sertorius_italy can be the source of gene flow. We further explore this by calculating the % of 


bootTrees = readBootstrapTrees("BSlistfiles")
bootnet = bootsnaq(net0, bootTrees, hmax=1, nrep=10, runs=10, filename="bootsnaq", seed=4321)

# net1 = readTopology(joinpath(dirname(pathof(PhyloNetworks)), "..","examples","net1.out")) #load net1

BSn, BSe, BSc, BSgam, BSedgenum = hybridBootstrapSupport(bootnet, net1)

R"name = function(x) file.path(x)" # function to create file name in appropriate folder
R"svg(name('network.svg'), width=6, height=6)" # starts image file
R"par"(mar=[4,4,4,4]) # to reduce margins 
plot(net1, :R, nodeLabel=filter(r->r[:BS_minor_sister]>5, BSn)[!,[:node,:BS_minor_sister]]);
R"dev.off()"; # wrap up and save image file