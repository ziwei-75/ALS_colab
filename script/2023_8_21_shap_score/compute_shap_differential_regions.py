import pandas as pd
import sys
import pyfaidx
sys.path.append("/oak/stanford/groups/akundaje/ziwei75/HTRANet/HTRANet/mpra/src/train")
sys.path.append("/oak/stanford/groups/akundaje/ziwei75/ALS_colab/script/2023_8_21_shap_score")
import one_hot
import shap_utils
import shap
import tensorflow as tf
from tensorflow.keras.models import load_model
import numpy as np
tf.compat.v1.disable_eager_execution()

def interpret(model, seqs, profile_or_counts):
    print("Seqs dimension : {}".format(seqs.shape))

    outlen = model.output_shape[0][1]

    profile_model_input = model.input
    profile_input = seqs
    counts_model_input = model.input
    counts_input = seqs

    if profile_or_counts == "counts":
        profile_model_counts_explainer = shap.explainers.deep.TFDeepExplainer(
            (counts_model_input, tf.reduce_sum(model.outputs[1], axis=-1)),
            shap_utils.shuffle_several_times,
            combine_mult_and_diffref=shap_utils.combine_mult_and_diffref)

        print("Generating 'counts' shap scores")
        counts_shap_scores = profile_model_counts_explainer.shap_values(
            counts_input, progress_message=100)
        return counts_shap_scores
        
    if profile_or_counts == "profile":
        weightedsum_meannormed_logits = shap_utils.get_weightedsum_meannormed_logits(model)
        profile_model_profile_explainer = shap.explainers.deep.TFDeepExplainer(
            (profile_model_input, weightedsum_meannormed_logits),
            shap_utils.shuffle_several_times,
            combine_mult_and_diffref=shap_utils.combine_mult_and_diffref)

        print("Generating 'profile' shap scores")
        profile_shap_scores = profile_model_profile_explainer.shap_values(
            profile_input, progress_message=100)    
        return profile_shap_scores

differential_regions=pd.read_csv("/oak/stanford/groups/akundaje/ziwei75/ALS_colab/sod1_project/differential_regions_alpha_MNs/differentialRegions.bed",\
                                 sep='\t',\
                                header=None)
genome="/oak/stanford/groups/akundaje/ziwei75/atac_seq_pipeline/mm10/mm10_no_alt_analysis_set_ENCODE.fasta"
genome = pyfaidx.Fasta(genome)
sequences = []
flank_size=2114//2
for i, row in differential_regions.iterrows():
    chromo, start, end = row
    center = (start+end)//2
    start = center - flank_size 
    end = center + flank_size
    seq = genome[chromo][start:end].seq
    sequences += [seq]   
sequences=one_hot.dna_to_one_hot(sequences)

cell_type=sys.argv[1]
fold_number=sys.argv[2]
# cell_type="alpha_control"
# fold_number=0
print(cell_type,fold_number)
model = "/oak/stanford/groups/akundaje/ziwei75/ALS_colab/models/2023_8_10/%s/fold%s/models/chrombpnet_nobias.h5"%(cell_type,fold_number)
model = load_model(model)
    
count_shap_score = interpret(model, sequences, "counts")
profile_shap_score = interpret(model, sequences, "profile")

count_shap_file="/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/differential_region/%s_fold%s_count_shap.npz"%(cell_type,fold_number)
profile_shap_file="/oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/differential_region/%s_fold%s_profile_shap.npz"%(cell_type,fold_number)

np.savez(count_shap_file,count_shap_score)
np.savez(profile_shap_file,profile_shap_score)