#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=50G
#SBATCH --time=04:00:00
#SBATCH --job-name=Jellyfish-3
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/jelly3_output_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/jelly3_error_%j.e
#SBATCH --partition=pall

# Create link to data directory and list of datasets
cd /data/users/qcoxon/Assembly-SA2023
data=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1
datasets=("Illumina" "pacbio" "RNAseq")



# Add the jellyfish module
module load UHTS/Analysis/jellyfish/2.3.0

# Start with Illumina 
set=Illumina
mkdir Results/02-Jellyfish/Attempt02/${set}
jellyfish count -C -m 21 -s 5G -t 4 <(zcat ${data}/${set}/*1.fastq.gz) <(zcat ${data}/${set}/*2.fastq.gz) -o Results/02-Jellyfish/${set}/reads_${set}.jf
