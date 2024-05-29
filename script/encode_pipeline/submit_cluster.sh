#!/bin/bash
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH --export=ALL
#SBATCH --mem 64G
#SBATCH --partition=akundaje
#SBATCH -J fetal_brain

# output to /scratch instead of /oak
sample=$1
echo $sample
mkdir -p /scratch/users/ziwei75/ALS_colab/output/$sample/
caper run ~/atac-seq-pipeline/atac.wdl -i ./$sample.json --out-dir /scratch/users/ziwei75/ALS_colab/output/$sample/ --tmp-dir /scratch/users/ziwei75/ALS_colab/output/$sample/.caper_tmp --conda encd-atac

