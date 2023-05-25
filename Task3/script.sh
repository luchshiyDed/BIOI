minimap2 -a -t 6 ./ref.fna ./my.fasta > res.sam
PROCENT=$(jq -r 'maped %' samtools flagstat -O json res.sam) 
echo PROCENT
if [ "$PROCENT" -gt "90" ]; then
    echo "ok"
else
    echo "not ok"
    exit 1
fi

samtools view -S -b ./res.sam > ./res.bam

samtools sort res.bam  -o resSort.bam

freebayes -f ./ref.fna ./resSort.bam > freb.vcf
