for cell_type in alpha_control  alpha_early_disease  alpha_midLate_disease  panGamma_control
do 
	./score_variants.sh $cell_type
done