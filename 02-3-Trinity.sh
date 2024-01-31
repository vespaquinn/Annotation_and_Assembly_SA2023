#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=12
#SBATCH --job-name=Trinity
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/Troutput%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/Trerror%j.e
#SBATCH --partition=pall
#---------------------------------------------------------------------------
# link to the data dir for RNAseq data 
data=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1/RNAseq
outdir=/data/users/qcoxon/Assembly-SA2023/Results/trinity
cd /data/users/qcoxon/Assembly-SA2023/Results/

# load the trinity module 
module load UHTS/Assembler/trinityrnaseq/2.5.1

# run trinity 
 Trinity --seqType fq --max_memory 48G \
         --left ${data}/*_1.fastq.gz --right ${data}/*_2.fastq.gz --CPU 12 --output trinity
