#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=50G
#SBATCH --time=04:00:00
#SBATCH --job-name=Jellyfish-histo
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/jelly_output_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/HISTOJELLY_%j.e
#SBATCH --partition=pall

# Create link to data directory and list of datasets
data=/data/users/qcoxon/Assembly-SA2023/Results/02-Jellyfish
datasets=("Illumina" "pacbio" "RNAseq")


# Add the jellyfish module
module load UHTS/Analysis/jellyfish/2.3.0

# Now loop over all the datasets in Illumina
for set in ${datasets[@]};
do cd ${data}/${set}
jellyfish histo -t 4 reads_${set}.jf > ${set}.histo
done


