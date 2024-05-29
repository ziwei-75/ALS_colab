while IFS=$'\t' read -r x y ; 
do echo $x $y ; 
croo  --out-dir /oak/stanford/groups/akundaje/ziwei75/ALS_colab/output/$x  --method copy /scratch/users/ziwei75/ALS_colab/output/$x/atac/$y/metadata.json 
done < hash_to_id
