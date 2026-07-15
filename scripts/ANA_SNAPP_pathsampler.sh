#!/bin/bash
#SBATCH --job=pathsampler
#SBATCH --account=Project_2002599
#SBATCH -o pathsampler_%j_out.txt
#SBATCH -e pathsampler_%j_error.txt
#SBATCH --partition=test
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com

################################################
#This script is to run path sampler seperately if the MCMC for each step is enough
#ESS is better > 200 and <1000, for >1000 is waste of time

module load beast/2.7.1

export case=`echo $PWD | sed 's:.*/::'`

applauncher PathSampleAnalyser -nrOfSteps 23 -alpha 0.3 -rootdir ./ -burnInPercentage 10 >`echo $case`_pathsampler.out 2>&1


##################################################
#below is just to rename the output and error file

rename ${SLURM_JOB_ID} `date +"%d%b%y_%H%M"` pathsampler_${SLURM_JOB_NAME}_*.txt
