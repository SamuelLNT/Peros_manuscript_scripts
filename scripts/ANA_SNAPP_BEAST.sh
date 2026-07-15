#!/bin/bash
#SBATCH --job-name=5sp_SNAPP
#SBATCH --account=Project_2002599
#SBATCH -o SNAPP_out_%A.txt
#SBATCH -e SNAPP_err_%A.txt
#SBATCH --partition=small
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --time=72:00:00
#SBATCH --mem-per-cpu=9500
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com

# commands to manage the batch script
#   submission command
#     sbatch [script-file]
#   status command
#     squeue -u vivanov
#   termination command
#     scancel [jobid]

sed -i "s|++DIR++|$PWD|g" *.xml

module load beast/2.7.5

beast -threads 24 *.xml > BEAST_run.out.txt 2>&1
#beast -resume -threads 40 *.xml > BEAST_run.out_resume.txt 2>&1


# This script will print some usage statistics to the
# end of file: Hyperborea_suc
# Use that to improve your resource request estimate
# on later jobs.
