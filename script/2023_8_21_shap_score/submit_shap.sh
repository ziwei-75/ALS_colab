for sample in alpha_control alpha_early_disease alpha_midLate_disease panGamma_control
	do
	for fold in 0 1 2 3 4 
		do 
		sbatch run_shap_score.sh $sample $fold
		echo "run_shap_score.sh for $sample $fold"
	done
done
