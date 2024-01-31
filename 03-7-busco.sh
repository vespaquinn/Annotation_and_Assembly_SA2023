#!/usr/bin/env bash
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name=busco-1
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/boutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/busco1_error%j.e
#SBATCH --cpus-per-task=24
#SBATCH --mem=60G
#SBATCH --time=08:00:00
#SBATCH --partition=pall
### RUN THIS SCRIPT 5 TIMES -------------
### RUNS COMPLETE 5/5       -------------

# Establish which run this is (polished/unpolished, flye/canu/trinity)
    # 1. polished flye; 2. unpolished flye; 3. polished canu; 4. unpolished canu; 5. polished trinity 
    #NB. trinity is classed as 'polished' since it undertakes polishing itself

## -------- !! NB !! CHANGE THESE TWO VARIABLES FOR EACH RUN !! ------
polishing=polished
assembler=flye 
## -------------------------------------------------------------------
# make sure mode is set correctly 
mode=genome
if [ "${assembler}" == "trinity" ];then
mode=transcriptome
fi
#---------------------------------------------------------------------
# Setup directories 
data_dir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/assemblies
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/busco
mkdir -p ${outdir}
cd ${outdir}

# define variables for BUSCO
assembly=${data_dir}/${assembler}_${polishing}.fasta

# Load and run BUSCO 
module add UHTS/Analysis/busco/4.1.4
busco -i ${assembly} -c 24 -o ${outdir}/${assembler}_${polishing} -m ${mode} -l brassicales_odb10

# -i input
# -c number of threads
# -o output name
