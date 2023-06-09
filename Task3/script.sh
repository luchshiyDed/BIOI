minimap2 -a -t 6 ./ref.fna ./my.fasta > res.sam
samtools flagstat -O json res.sam > tmp.json
PROCENT=$(jq -r '."QC-passed reads"."propely paired %"' tmp.json) 
echo PROCENT
if [[ $PROCENT ? -gt 90 ]]; then
    echo "ok"
else
    echo "not ok"
    exit 1
fi

samtools view -S -b ./res.sam > ./res.bam

samtools sort res.bam  -o res.sorted.bam

freebayes -f ./ref.fna ./res.sorted.bam > freb.vcf
