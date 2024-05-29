for fold in 0 1 2 3 4 
	do 
	sbatch run_chrombpnet.sh $fold
	echo "run chrombpnet for $fold"
done
