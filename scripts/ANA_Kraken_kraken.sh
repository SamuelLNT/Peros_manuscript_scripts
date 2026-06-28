#!/bin/bash -l
#SBATCH --job-name=kraken_Eros
#SBATCH --output=output_Eros.txt
#SBATCH --error=errors_Eros.txt
#SBATCH --time=05:00:00
#SBATCH --partition=small
#SBATCH --ntasks=1
#SBATCH --nodes=1  
#SBATCH --cpus-per-task=4
#SBATCH --account=project_number
#SBATCH --mem=60000
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com

### Note that I have created 4 folders before running, can be a part of the batch, silenced command below

mkdir Clean_seqs_Eros Bact_seqs_Eros Results_Eros Eros_bacteria_reports

module load biokit

for gfile in *_R1_.fastq.gz;
  do kraken2 -db standard --threads $SLURM_CPUS_PER_TASK --report ${gfile/_R1_.fastq.gz/}.report.txt \
             --gzip-compressed --classified-out ${gfile/_R1_.fastq.gz/}_CLAS_#.fq \
             --unclassified-out ${gfile/_R1_.fastq.gz/}_UNCL_#.fq \
             --paired $gfile ${gfile/_R1_.fastq.gz/_R2_.fastq.gz} > ${gfile/_R1_.fastq.gz/}_res.txt
  gzip *.fq
  gzip *res.txt
  mv *UNCL*gz /scratch/project_number/ddRAD_demultiplexed_projects/004_eros_eroides/raw_demul_reads/Clean_seqs_Eros/
  mv *CLAS*gz /scratch/project_number/ddRAD_demultiplexed_projects/004_eros_eroides/raw_demul_reads/Bact_seqs_Eros/
  mv *res.txt.gz /scratch/project_number/ddRAD_demultiplexed_projects/004_eros_eroides/raw_demul_reads/Results_Eros/
  mv *report.txt /scratch/project_number/ddRAD_demultiplexed_projects/004_eros_eroides/raw_demul_reads/Eros_bacteria_reports/

done
