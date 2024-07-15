#!/bin/sh
#SBATCH -A NAISS2023-5-119 -p alvis
#SBATCH -C NOGPU
#SBATCH -t 3-00:00:00

embeddings_folder="$1/LSC/LSCDiscovery-Spanish"
labels_folder="$2/LSC/LSCDiscovery-Spanish"
dataset_folder="$3/LSC/LSCDiscovery-Spanish"
layers=12

declare -a algorithms=("app")
declare -a models=("xlm-roberta-base" "bert-base-multilingual-cased" "dccuchile_bert-base-spanish-wwm-uncased")

for model in "${models[@]}"
do
	for algo in "${algorithms[@]}"
	do
		python src/clustering.py -a "${algo}" -e "${embeddings_folder}/${model}" -l "${layers}" -o "${labels_folder}/${model}" -t "${dataset_folder}/targets.txt"
	done
done
