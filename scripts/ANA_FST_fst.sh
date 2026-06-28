module load vcftools/0.1.17
vcftools --version

pwd
ls -1 *.vcf
inputvcf=($(ls -1 *m42*.vcf))
echo "${inputvcf[@]}"

ls -1 *_group.txt
groups=($(ls -1 *_group.txt))
echo "${groups[@]}"

# Loop over all unique pairs
for ((k=0; k<${#inputvcf[@]}; k++)); do
  for ((i=0; i<${#groups[@]}-1; i++)); do
    for ((j=i+1; j<${#groups[@]}; j++)); do
        g1=${groups[i]}
        g2=${groups[j]}
        input=${inputvcf[k]}
        outname="${g1%_group.txt}_${g2%_group.txt}_${input%.vcf}"
        vcftools --vcf $input --weir-fst-pop $g1 --weir-fst-pop $g2 --out $outname
    done
  done
done
