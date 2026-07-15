#!/bin/bash
#SBATCH --job-name=Dsuite_REF_icarus
#SBATCH --account=project_number
#SBATCH --partition=test
#SBATCH -o %x_%A_out.txt
#SBATCH -e %x_%A_error.txt
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=5G
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com

module load biokit
#Remove celina in vcf
#vcftools --remove-indv Pceli_R08R500_IT_U_M --vcf Eros_REF_icarus_aftrkr_merg_n55_c85_m35.vcf --recode --out Eros_REF_icarus_aftrkr_merg_n55_c85_m35_wfcelina
#vcftools --remove-indv Pceli_R08R500_IT_U_M --vcf Eros_after_krak_merged_n55_c85_m35.vcf --recode --out Eros_after_krak_merged_n55_c85_m35_wfcelina


export PATH='/scratch/project_number/Programme/Dsuite_v0.5_r53/Build/:$PATH'
#Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n default Eros_REF_icarus_aftrkr_merg_n55_c85_m35_wfcelina.recode.vcf full_species_set_MAY2024.txt 
#Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n default_ABBA --ABBAclustering Eros_REF_icarus_aftrkr_merg_n55_c85_m35_wfcelina.recode.vcf full_species_set_MAY2024.txt 
#Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n jk50_ABBA -k 50 --ABBAclustering Eros_REF_icarus_aftrkr_merg_n55_c85_m35_wfcelina.recode.vcf full_species_set_MAY2024.txt

#Dsuite Dtrios -o Eros_denv_n55_c85_m35 -n default Eros_after_krak_merged_n55_c85_m35_wfcelina.recode.vcf full_species_set_MAY2024.txt
#Dsuite Dtrios -o Eros_denv_n55_c85_m35 -n default_ABBA --ABBAclustering Eros_after_krak_merged_n55_c85_m35_wfcelina.recode.vcf full_species_set_MAY2024.txt 
#Dsuite Dtrios -o Eros_denv_n55_c85_m35 -n jk50_ABBA -k 50 --ABBAclustering Eros_after_krak_merged_n55_c85_m35_wfcelina.recode.vcf full_species_set_MAY2024.txt

#5June2024 Trying to reduce eroides' classification to only eroides
#Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n jk50_reduced_ABBA -k 50 --ABBAclustering Eros_REF_icarus_aftrkr_merg_n55_c85_m35_wfcelina.recode.vcf reduced_specieslist_June2024.txt
#Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n def_reduced_ABBA  --ABBAclustering Eros_REF_icarus_aftrkr_merg_n55_c85_m35_wfcelina.recode.vcf reduced_specieslist_June2024.txt

#Retain samples from  vcf
#3 Dec to rerun Dsuite for only Austrian, Pyrenen eros and icarus
#vcftools --keep keep3.txt --vcf Eros_REF_icarus_aftrkr_merg_n55_c85_m35.vcf --recode --out Eros_REF_icarus_aftrkr_merg_n55_c85_m35_case3.recode.vcf

Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n case3_ABBA_onlyATeros  --ABBAclustering Eros_REF_icarus_aftrkr_merg_n55_c85_m35_case3.recode.vcf case3_splist.txt
Dsuite Dtrios -o Eros_REF_icarus_n55_m35 -n jk50_case3_ABBA_onlyATeros -k 50  --ABBAclustering Eros_REF_icarus_aftrkr_merg_n55_c85_m35_case3.recode.vcf case3_splist.txt
