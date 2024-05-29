#!/bin/bash
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH -G 1
#SBATCH --mem=48GB
#SBATCH --partition=akundaje,gpu
module load cuda/11.2.0 
module load cudnn/8.1.1.33
module load pango
module load system cairo

sample=alpha_control
fold_number=0

chrombpnet bias pipeline \
  -itag /oak/stanford/groups/akundaje/ziwei75/ALS_colab/sod1_project/tagalign_files/alpha_control.tagalign.gz \
  -d "ATAC" \
  -g /oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt_analysis_set_ENCODE.fasta \
  -c /oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt.chrom.sizes.tsv \
  -p /oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/$sample/peak/overlap_reproducibility/overlap.conservative_peak.narrowPeak.gz \
  -n /oak/stanford/groups/akundaje/ziwei75/ALS_colab/nonpeaks/$sample/${fold_number}_negatives.bed \
  -fl /oak/stanford/groups/akundaje/ziwei75/ALS_colab/folds/fold_${fold_number}.json \
  -b 0.4 \
  -o /oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10_bias/ 
