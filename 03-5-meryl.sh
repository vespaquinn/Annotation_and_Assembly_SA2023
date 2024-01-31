#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --job-name=meryl_streep
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/moutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/merror_%j.e
#SBATCH --partition=pall

### Run this script 1 time.

#Add the modules
    module add UHTS/Assembler/canu/2.1.1

#Specify directory structure and create them
    meryl_dir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/meryl
    mkdir ${meryl_dir}

#Specify where the raw reads are stored (no soft link)
    data_dir=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1/Illumina

#Run meryl to create db for merqury
    meryl k=19 count output $SCRATCH/read_1.meryl ${data_dir}/*1.fastq.gz
    meryl k=19 count output $SCRATCH/read_2.meryl ${data_dir}/*2.fastq.gz
    meryl union-sum output ${meryl_dir}/genome.meryl $SCRATCH/read*.meryl