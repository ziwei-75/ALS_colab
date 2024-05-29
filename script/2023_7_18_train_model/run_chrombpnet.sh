#!/bin/bash
#SBATCH --time=4-00:00:00
#SBATCH --ntasks=1
#SBATCH -G 1
#SBATCH --mem=60GB
#SBATCH --partition=akundaje
module load cuda/11.2.0 
module load cudnn/8.1.1.33
module load pango
module load system cairo

sample=$1
fold_number=$2
echo $sample $fold_number
mkdir -p /oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10/$sample/
chrombpnet pipeline \
  -itag /oak/stanford/groups/akundaje/ziwei75/ALS_colab/sod1_project/tagalign_files/$sample.tagalign.gz \
  -d "ATAC" \
  -g /oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt_analysis_set_ENCODE.fasta \
  -c /oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt.chrom.sizes.tsv \
  -p /oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/$sample/peak/overlap_reproducibility/overlap.optimal_peak.narrowPeak.gz \
  -n /oak/stanford/groups/akundaje/ziwei75/ALS_colab/nonpeaks/$sample/${fold_number}_negatives.bed \
  -fl /oak/stanford/groups/akundaje/ziwei75/ALS_colab/folds/fold_${fold_number}.json \
  -b /oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10_bias/models/bias.h5 \
  -o /oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10/$sample/fold${fold_number}/
