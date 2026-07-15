#!/bin/bash
#SBATCH --job-name=stairway_ar
#SBATCH --account=project_number
#SBATCH --partition=small
#SBATCH --out=stplot_ar_%A_%a.out ##use standard output for all the array job
#SBATCH --error=stplot_ar_%A_%a.error ## use standard output in this array job
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=2G
#SBATCH --mail-type=END
#SBATCH --mail-user=username@gmail.com
#SBATCH --array=0-6%7

module load biojava
module list

echo "this blueprint is using 1x projection as nseq, and uses the even projection form easySFS, and removed invariable bin (first bin). Rerun for all sites written out from bcftools vcf files, using output-5 from easysfs"

pwd

export PATH="/projappl/project_number/SFS_kit/stairway-plot-v2/:$PATH"

list=($(cat blueprint.list))
file="${list[$SLURM_ARRAY_TASK_ID]}"

  base=$(basename "$file" _folded.blueprint);
  echo $base;
  java -cp stairway_plot_es Stairbuilder "$base"_folded.blueprint
  bash "$base"_folded.blueprint.sh
  mkdir -p "$base"_plot
  mv "$base"_folded* "$base"_plot/


mkdir -p final_summary
cp ./"$base"_plot/"$base"_folded/"$base"_folded.final.summary final_summary/

