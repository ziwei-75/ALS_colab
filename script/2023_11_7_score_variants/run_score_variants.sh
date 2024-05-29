cell_type=alpha_control
for fold in fold0 fold1 fold2 fold3 fold4
do 
	echo "sbatch ./score_variants.sh $cell_type $fold"
	sbatch ./score_variants.sh $cell_type $fold
done
