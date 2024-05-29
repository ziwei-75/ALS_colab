for fold in 0 1 2 3 4 
do
    genome=/oak/stanford/groups/akundaje/ziwei75/T2D_MPRA/data/ref_data/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta
    output_prefix=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/nonpeaks/answer_als/merged_control/merged_control_fold${fold}
    peaks=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/answer_ALS/chrombpnet_input/merged_overlap_optimal_peaks.narrowPeak
    chromo_sizes=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/GRCh38_EBV.chrom.sizes.tsv 
    chr_fold_path=/oak/stanford/groups/akundaje/ziwei75/T2D_MPRA/src/splits/fold_${fold}.json 
    input_length=2114
    stride=1000
    neg_to_pos_ratio_train=1
    blacklist_regions=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/ENCFF356LFX.bed.gz
    seed=42
    chrombpnet prep nonpeaks -g $genome -o $output_prefix -p $peaks -c $chromo_sizes -fl $chr_fold_path -il $input_length -st $stride -npr $neg_to_pos_ratio_train -br $blacklist_regions -s $seed
done
