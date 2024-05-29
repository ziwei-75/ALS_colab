#!/bin/bash
#SBATCH --time=2-00:00:00
#SBATCH --ntasks=1
#SBATCH -G 1
#SBATCH --mem=40GB
#SBATCH --partition=akundaje,owners
module load cuda/11.2.0 
module load cudnn/8.1.1.33
module load pango
module load system cairo

sample=$1
fold_number=$2
echo $sample $fold_number
python compute_shap_differential_regions.py $sample $fold_number
