#!/bin/bash
#SBATCH --time=4-00:00:00
#SBATCH --ntasks=1
#SBATCH -G 1
#SBATCH --mem=256GB
#SBATCH --partition=akundaje
module load cuda/11.2.0 
module load cudnn/8.1.1.33
module load pango
module load system cairo

fold_number=$1
echo $fold_number
python /oak/stanford/groups/akundaje/ziwei75/chrombpnet/chrombpnet/train_chrombpnet.py pipeline \
  -ibam /oak/stanford/groups/akundaje/ziwei75/ALS_colab/answer_ALS/chrombpnet_input/pooled_control.bam \
  -d "ATAC" \
  -g /oak/stanford/groups/akundaje/ziwei75/T2D_MPRA/data/ref_data/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta \
  -c /oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/GRCh38_EBV.chrom.sizes.tsv \
  -p /oak/stanford/groups/akundaje/ziwei75/ALS_colab/answer_ALS/chrombpnet_input/merged_overlap_optimal_peaks.narrowPeak \
  -n /oak/stanford/groups/akundaje/ziwei75/ALS_colab/nonpeaks/answer_als/merged_control/merged_control_fold${fold_number}_negatives.bed \
  -fl /oak/stanford/groups/akundaje/ziwei75/T2D_MPRA/src/splits/fold_${fold_number}.json \
  -b /oak/stanford/groups/akundaje/ziwei75/crispr_design/models/bias_model/ENCSR868FGK_bias_fold_0.h5 \
  -o /oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2024_2_9_answer_als/merged_control/fold${fold_number}/
