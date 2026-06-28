#!/bin/bash
#SBATCH --job-name=CLADES
#SBATCH --account=project_number
#SBATCH --partition=small
#SBATCH -o CLADES_out_%j.txt
#SBATCH -e CLADES_error_%j.txt
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=END
#SBATCH --mail-user=samueluob@gmail.com

export PATH="/projappl/project_number/clades-env/bin/:$PATH"

cd /scratch/project_number/ddRAD_demultiplexed_projects/004_eros_eroides/process_files/Eros_icarus_REF/CLADES/Full_REF_icarus_m35/

python /projappl/project_number/clades-env/CLADES/CLADES.py REF_n55_m35_50_55cov_ingrp /projappl/project_number/clades-env/CLADES/model/All

mkdir CLADES_out_${SLURM_JOB_ID}
mv *.out CLADES_out_${SLURM_JOB_ID}
mv *sumstat* CLADES_out_${SLURM_JOB_ID}

