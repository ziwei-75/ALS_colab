#!/bin/bash

cell_type=$1
model=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10/$cell_type/fold0/models/chrombpnet_nobias.h5
variant_path=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/predicted_significant_variants_pval_0.05.tsv
genome=/oak/stanford/groups/akundaje/ziwei75/T2D_MPRA/data/ref_data/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta
sizes=/oak/stanford/groups/akundaje/ziwei75/T2D_MPRA/data/ref_data/hg38.chrom.sizes
out_prefix=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/variant_scoring/$cell_type/vanRheene_2021_summaray_significant_shap
python /oak/stanford/groups/akundaje/ziwei75/variant_scoring/variant-scorer/src/variant_shap.py -l $variant_path \
                             -g $genome \
                             -s $sizes \
                             -m $model \
                             -o $out_prefix \
                             -sc original 
                             
                             
