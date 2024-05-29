#!/bin/bash

cell_type=$1
list=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/sod1_project/vanRheene_2021_summary_significant_variants_include_all.tsv
genome=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta
sizes=/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/hg38/GRCh38_EBV.chrom.sizes.tsv
model=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10/$cell_type/fold0/models/chrombpnet_nobias.h5
out_prefix=/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/variant_scoring/$cell_type/vanRheene_2021_summaray_significant
mkdir -p /oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/variant_scoring/$cell_type/
python /oak/stanford/groups/akundaje/ziwei75/variant_scoring/variant-scorer/src/variant_scoring.py -l $list \
        -g $genome \
        -s $sizes \
        -m $model \
        --schema original \
        -o $out_prefix \
        -n 10 \


