#!/usr/bin/env bash

#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --job-name=merqury1 
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/meroutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/mererror_%j.e
#SBATCH --partition=pall


### Run this script 4 times.
#1. polished canu, #2. polished flye, #3. unpolished canu, #4. unpolished flye
#---1 
polishing=polished
assembler=canu

#Specify directories
course_dir=/data/users/qcoxon/Assembly-SA2023
data_dir=${course_dir}/Results/03-Polishing/assemblies
meryl_dir=${course_dir}/Results/03-Polishing/meryl
merqury_dir=${course_dir}/Results/03-Polishing/merqury
mkdir ${merqury_dir}

# create the output directory and declare which assembly is being used 
assembly_merqury_dir=${merqury_dir}/${assembler}_${polishing}}
mkdir ${assembly_merqury_dir}
assembly=${data_dir}/${assembler}_${polishing}.fasta


#Change permisson of assembly otherwise there is an error (I did not fully understand why) and go to folder where results should be stored.
    #chmod ugo+rwx ${assembly}
    cd ${assembly_merqury_dir}
#Run merqury to assess quality of the assemblies; do not indent
apptainer exec \
--bind $course_dir \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh ${meryl_dir}/genome.meryl ${assembly} ${assembler}_${polishing}
