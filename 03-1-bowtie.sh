#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/bt2output_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/bt2error_%j.e
#SBATCH --partition=pall
#SBATCH --job-name=bt2-canu
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

# create data links
illumina_reads=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1/Illumina

# enter the flye Results directory
cd /data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/flye

# Load the bt2 module
module load UHTS/Aligner/bowtie2/2.3.4.1

# run bowtie 2 
    # assembly.fasta is the assembly we want to index
    # flindex is the prefix we will include in the outputs
    # -f specifies that the assemblies are in fasta form (not given as strings on the command line)
    # --threads specifies number of threads (surprisingly)
#bowtie2-build -f --threads 8 assembly.fasta flindex

# repeat the process for canu
cd ../canu
bowtie2-build -f --threads 8 canu_pacbio.contigs.fasta canindex
