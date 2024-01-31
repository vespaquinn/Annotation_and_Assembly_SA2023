#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=FASTQC
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/output_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/error_%j.e
#SBATCH --partition=pall

# Go into project directory and make results directory 
cd /data/users/qcoxon/Assembly-SA2023
mkdir Results
mkdir Results/01-QC

# Create link to data directory and list of datasets

data=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1
datasets=("Illumina" "pacbio" "RNAseq")

# Add the fastqc module
module load UHTS/Quality_control/fastqc/0.11.9

# Now loop over all the datasets in Illumina
for set in ${datasets[@]};
do mkdir Results/01-QC/${set}
fastqc -t 2 ${data}/${set}/* -o Results/01-QC/${set}
done



