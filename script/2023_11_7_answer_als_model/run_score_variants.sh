for fold in fold0 fold1 fold2 fold3 fold4
do 
	echo "sbatch ./score_variants.sh $fold"
	sbatch ./score_variants.sh $fold
done
