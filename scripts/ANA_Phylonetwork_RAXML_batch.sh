#!/bin/bash
#SBATCH --job-name=Ero_RAX
#SBATCH --account=project_number
#SBATCH --partition=small
#SBATCH -o Ero_RAX_out.txt
#SBATCH -e Ero_RAX_error.txt
#SBATCH --time=32:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com

module load biojava
module load perl
module load raxml

perl raxml.pl --noconvert2phylip --seqdir=./loci --raxmldir=raxml --nodoastral
