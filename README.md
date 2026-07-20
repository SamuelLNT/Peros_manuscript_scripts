# Introduction to the repository
This is a repository associated with the the manuscript titled "Genetic structure, spectral characteristics and evolutionary history of butterflies in the European Polyommatus eros species group (Lepidoptera, Lycaenidae)". You can find the scripts and essential data used to run the script presented in the manuscript.
If you have any question related to the manuscript or the scripts, you can contact me through nok.lam@oulu.fi or nokting.lam.samuel@gmail.com

# Layouts of the repository

The repository has several directories, as show below:

```
├── GIS
│   ├── Eroides_italy (Tshikolovets,2011).kml
│   ├── Eros_Macedonia (colin).kml
│   ├── P. eros italica (Leraut_2016).kml
│   ├── Test_polygon.kml
│   ├── boisduvalii_CZ_extinct (Tshikolovak,2011).kml
│   ├── boisduvalii_CZ_extinct2.kml
│   ├── boisduvalii_CZ_extinct3.kml
│   ├── boisduvalii_CZ_extinct4.kml
│   ├── boisduvalii_UR_RU (Tschikolovak,2011).kml
│   ├── eors_massif.kml
│   ├── eroides_PL_extinct1.kml
│   ├── eroides_PL_extinct2.kml
│   ├── eroides_PL_extinct3.kml
│   ├── eroides_PL_extinct4.kml
│   ├── eroides_Turkey_2_atlas2015.kml
│   ├── eroides_balkan (Tshikolovets,2011).kml
│   ├── eroides_turkey (Tschikolovets,2011).kml
│   ├── eros_alps.kml
│   ├── eros_balkan (colin).kml
│   ├── eros_bosinia(Tshikolovets,2011).kml
│   ├── eros_bosinia2 (Tschikolovets,2011).kml
│   ├── eros_croatia.kml
│   ├── eros_pyrenees.kml
│   ├── kmllist.txt
│   └── menelaos_allbooks.kml
├── LICENSE
├── README.md
├── paramfiles
│   ├── Ipyrad_params-Eros_REF_icarus_aftrkr_merg_n54_c85_m35.txt
│   ├── Ipyrad_params-Eros_REF_icarus_aftrkr_merg_n55_c85_m15.txt
│   ├── Ipyrad_params-Eros_REF_icarus_aftrkr_merg_n55_c85_m25.txt
│   ├── Ipyrad_params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt
│   ├── Ipyrad_params-Eros_REF_icarus_aftrkr_merg_n55_c85_m45.txt
│   ├── Ipyrad_params-Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m27.txt
│   ├── Ipyrad_params-Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m42.txt
│   ├── SNAPP_1sp_reduce_PATH.xml
│   ├── SNAPP_2Asp_reduce_PATH.xml
│   ├── SNAPP_2Bsp_reduce_PATH.xml
│   ├── SNAPP_2Csp_reduce_PATH.xml
│   ├── SNAPP_2Dsp_reduce_PATH.xml
│   ├── SNAPP_3Asp_reduce_PATH.xml
│   ├── SNAPP_3Bsp_reduce_PATH.xml
│   ├── SNAPP_3Csp_reduce_PATH.xml
│   ├── SNAPP_3Dsp_reduce_PATH.xml
│   ├── SNAPP_4Asp_reduce_PATH.xml
│   ├── SNAPP_4Bsp_reduce_PATH.xml
│   ├── SNAPP_5sp_reduce_PATH.xml
│   ├── SNAPP_6sp_reduce_PATH.xml
│   ├── STRUCTURE_extraparams
│   ├── STRUCTURE_mainparams
│   ├── Stairwayplot_bois_folded.blueprint
│   ├── Stairwayplot_erAL_folded.blueprint
│   ├── Stairwayplot_eroi_folded.blueprint
│   ├── Stairwayplot_eros_folded.blueprint
│   ├── Stairwayplot_ital_folded.blueprint
│   ├── Stairwayplot_mene_folded.blueprint
│   └── Stairwayplot_out_folded.blueprint
├── scripts
    ├── ANA_CLADES_CLADES.py
    ├── ANA_CLADES_CLADES.sh
    ├── ANA_CLADES_filtering.log
    ├── ANA_CLADES_rename_reduce_6treeclus
    ├── ANA_DAPC_n55_m35_treetopology.csv
    ├── ANA_DAPC_rscript.R
    ├── ANA_Dsuite_Dsuite.sh
    ├── ANA_Dsuite_case1_splist.txt
    ├── ANA_Dsuite_case2_splist.txt
    ├── ANA_Dsuite_case2a_splist.txt
    ├── ANA_Dsuite_case3_splist.txt
    ├── ANA_Dsuite_full_species_set_MAY2024.txt
    ├── ANA_Dsuite_keep1.txt
    ├── ANA_Dsuite_keep2.txt
    ├── ANA_Dsuite_keep3.txt
    ├── ANA_FST_fst.sh
    ├── ANA_FST_grouplist.txt
    ├── ANA_IQtree_array.sh
    ├── ANA_IQtree_iqtreelist.txt
    ├── ANA_Ipyrad_icarus_REF.sh
    ├── ANA_Kraken_kraken.sh
    ├── ANA_PCA_CommandHistory.txt
    ├── ANA_PCA_Original_CommandHistory.txt
    ├── ANA_PCA_Original_ScreenOutput.txt
    ├── ANA_Phylonetwork_Eros_REF_icarus_aftrkr_merg_n54_c85_m35.tre
    ├── ANA_Phylonetwork_Instructions.txt
    ├── ANA_Phylonetwork_RAXML_Loci2Phylip_convert_from0.py
    ├── ANA_Phylonetwork_RAXML_batch.sh
    ├── ANA_Phylonetwork_RAXML_raxml.pl
    ├── ANA_Phylonetwork_besttrees.tre
    ├── ANA_Phylonetwork_cmd.log
    ├── ANA_Phylonetwork_eros_MAP_ASTRAL.txt
    ├── ANA_Phylonetwork_eros_MAP_PHYLONET.txt
    ├── ANA_Phylonetwork_eros_grouping.txt
    ├── ANA_Phylonetwork_eros_groupping_for_phylo.txt
    ├── ANA_Phylonetwork_phylonetworks_script.jl
    ├── ANA_Phylonetwork_screenoutput.log
    ├── ANA_SNAPP_BEAST.sh
    ├── ANA_SNAPP_SNPsFilter.R
    ├── ANA_SNAPP_pathsampler.sh
    ├── ANA_SNAPP_testedmodel.xlsx
    ├── ANA_STRUCTURE_extraparams
    ├── ANA_STRUCTURE_input.py
    ├── ANA_STRUCTURE_mainparams
    ├── ANA_Stairwayplot_blueprint.list
    ├── ANA_Stairwayplot_prepare_cmd.log
    ├── ANA_Stairwayplot_stairwaplot.sh
    ├── Fig1_STRUCTURE_Plot_on_map.R
    ├── Fig1_STRUCTURE_match_tree.R
    └── FigS10_Stairwayplot.R
```
### Summary for each directory

GIS: Contains all the polygon files to plot the distribution range in Figure 1, you can plot them in any GIS tools, like Google Earth, QGIS or ArcGIS...

scripts: Contains all the scripts used in the manuscripts - 
 - Files with prefix "ANA_AnalysesName_" are files used for analyses
 - Files with prefix "FigX" are scripts used to generate corresponding figures
 - If figures are not prepared with a separated script, the figure is plotted using the same analysis script
 - Within this directory, you will find executable script like `.R`, `.sh`, `.pl` and `.py`. However, some of the analyses were running in an interactive shell, the commands used were either in `.log` or `.txt`.
 - The script used in the manuscript were annotated with comments as detail as possible, but some might have been missed out, drop me a message if you want some explainations
 
paramfiles: Contains paramfiles for analyses, it is sorted into different analyses

