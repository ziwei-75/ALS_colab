#!/bin/bash
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH -G 1
#SBATCH --mem=128GB
#SBATCH --partition=akundaje,owners
module load cuda/11.2.0
module load cudnn/8.1.1.33

fold_number=$1
list=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/sod1_project/variant_file/vanRheene_2021_250kb_from_lead_formatted.tsv

genome=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta
sizes=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/GRCh38_EBV.chrom.sizes.tsv
model=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_11_7_answer_als/merged_control/$fold_number/models/chrombpnet_nobias.h5
#model=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10/$cell_type/$fold_number/models/chrombpnet_nobias.h5
out_prefix=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/variant_scoring/answer_als/vanRheene_2021_250kb_from_lead_${fold_number}
echo $model, $out_prefix
python /oak/stanford/groups/akundaje/ziwei75/variant_scoring/variant-scorer/src/variant_scoring.py -l $list \
        -g $genome \
        -s $sizes \
        -m $model \
        --schema original \
        -o $out_prefix \
        --num_shuf 10

