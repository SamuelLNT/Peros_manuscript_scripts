#!/bin/bash
#SBATCH --job-name=Eros_IQtree
#SBATCH --account=project_number
#SBATCH --partition=small
#SBATCH -o OUT_%x_%A_%a.txt
#SBATCH -e ERROR_%x_%A_%a.txt
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=10G
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com
#SBATCH --array=0-3

export job=($(cat iqtreelist.txt))

echo  currently working on ${job[${SLURM_ARRAY_TASK_ID}]}

module load iqtree/2.2.2.7

iqtree2 -v

cat IQtree_ar.sh


iqtree2 -s ${job[${SLURM_ARRAY_TASK_ID}]} -m MFP -T AUTO -alrt 5000 -B 5000 -bnni -pre ${job[${SLURM_ARRAY_TASK_ID}]}
