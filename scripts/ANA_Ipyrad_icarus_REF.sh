#!/bin/bash
#SBATCH --job-name=icarus_REF
#SBATCH --account=project_number
#SBATCH --partition=small
#SBATCH -o %x_%A_out.txt
#SBATCH -e %x_%A_error.txt
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --mem-per-cpu=16G
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com

module load ipyrad/0.9.92

#####
###2June2024 Mapping to icarus genome
#####

##-s = step number | -c = notify the number of core that the programme can use
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -s 1234567 -c 20 -t 1 -f
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_aftrkr_merg_n55_c85_m25
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_aftrkr_merg_n55_c85_m15
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_aftrkr_merg_n55_c85_m45

#sed -i '23s/35/25/g' params-Eros_REF_icarus_aftrkr_merg_n55_c85_m25.txt
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m25.txt -s 7 -c 20 -t 1

#sed -i '23s/35/15/g' params-Eros_REF_icarus_aftrkr_merg_n55_c85_m15.txt
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m15.txt -s 7 -c 20 -t 1


#sed -i '23s/35/45/g' params-Eros_REF_icarus_aftrkr_merg_n55_c85_m45.txt
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m45.txt -s 7 -c 20 -t 1

#####
###3June2024 Branching ingrp for STRUCTURE
#####

#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m42 - Pceli_R08R500_IT_U_M Picar_R08M425_RO_U_M Picar_R17D470_GR_U_M
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m27 - Pceli_R08R500_IT_U_M Picar_R08M425_RO_U_M Picar_R17D470_GR_U_M

#sed -i '23s/35/27/g' params-Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m27.txt
#ipyrad -p params-Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m27.txt -s 7 -c 20 -t 1

#sed -i '23s/35/42/g' params-Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m42.txt
#ipyrad -p params-Eros_ingrp_REF_icarus_aftrkr_merg_n52_c85_m42.txt -s 7 -c 20 -t 1



#####
###16December2024 Branching to remove sample with more than 40% missing data
#####

#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_rm40missingdata_full_n41_c85_m21 rm40missing_full_n41.txt
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_rm40missingdata_ing_n38_c85_m18 rm40missing_ing_n38.txt

#ipyrad -p params-Eros_REF_icarus_rm40missingdata_full_n41_c85_m21.txt -s 7 -c 20 -t 1
#ipyrad -p params-Eros_REF_icarus_rm40missingdata_ing_n38_c85_m18.txt -s 7 -c 20 -t 1

#####
###17December2024 Branching for ingroup m32 m30
#####

#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_ingrp_n52_m32 ingroup.txt
#ipyrad -p params-Eros_REF_icarus_aftrkr_merg_n55_c85_m35.txt -b Eros_REF_icarus_ingrp_n52_m30 ingroup.txt

#ipyrad -p params-Eros_REF_icarus_ingrp_n52_m32.txt -s 7 -c 20 -t 1
#ipyrad -p params-Eros_REF_icarus_ingrp_n52_m30.txt -s 7 -c 20 -t 1
