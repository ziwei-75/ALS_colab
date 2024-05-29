for sample in alpha_control alpha_early_disease alpha_midLate_disease panGamma_control
	do
	for fold in 0 1 2 3 4 
		do 
		sbatch run_chrombpnet.sh $sample $fold
		echo "run chrombpnet for $sample $fold"
	done
done
