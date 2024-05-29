for sample in alpha_early_disease alpha_midLate_disease panGamma_control alpha_control
do
for fold in 0 1 2 3 4 
do
	echo $sample $fold
	genome=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt_analysis_set_ENCODE.fasta
	output_prefix=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/nonpeaks/$sample/$sample_fold${fold}
	peaks=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/$sample/peak/overlap_reproducibility/overlap.conservative_peak.narrowPeak.gz
	chromo_sizes=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt.chrom.sizes.tsv
	chr_fold_path=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/folds/fold_${fold}.json
	input_length=2114
	stride=1000
	neg_to_pos_ratio_train=1
	blacklist_regions=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/ENCFF547MET.bed.gz
	seed=42
	chrombpnet prep nonpeaks -g $genome -o $output_prefix -p $peaks -c $chromo_sizes -fl $chr_fold_path -il $input_length -st $stride -npr $neg_to_pos_ratio_train -br $blacklist_regions -s $seed
done
done
