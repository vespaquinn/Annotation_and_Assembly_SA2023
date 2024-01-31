#!/usr/bin/env bash

#SBATCH --job-name=TESortArabadopsis
#SBATCH --time=12:00:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/TEAstsort_%j.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/TEAsort_%j.e
#SBATCH --partition=pall
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

#----------------------------------------------------
## setup of directories etc.
#----------------------------------------------------

project_dir=/data/users/qcoxon/annotation-SA2023
course_dir=/data/courses/assembly-annotation-course
outdir=${project_dir}/results/01-TE-Arabadopsis
mkdir -p ${outdir}
###TElib=/data/courses/assembly-annotation-course/CDS_annotation/EDTA_v1.9.6_new/Ler_flye.fasta.mod.EDTA.TElib.fa
TElib=/data/users/qcoxon/annotation-SA2023/results/01-EDTA/flye_polished.fasta.mod.EDTA.TElib.fa
   
#----------------------------------------------------
## separating the copia and gypsy sequences from the TE library 
#----------------------------------------------------

# load seqkit 
module load UHTS/Analysis/SeqKit/0.13.2

# subset TElibrary into only the QUERY superfamily
seqkit grep -r -p Copia ${TElib} -o ${outdir}/copia.fa
seqkit grep -r -p Gypsy ${TElib} -o ${outdir}/gypsy.fa

#----------------------------------------------------
##  TEsorter 
#----------------------------------------------------
cd ${outdir}

#--- copia 
singularity exec \
--bind ${course_dir} \
--bind ${outdir}  \
${course_dir}/containers2/TEsorter_1.3.0.sif \
TEsorter ${outdir}/copia.fa -db rexdb-plant -pre copia 

#--- gypsy 
singularity exec \
--bind ${course_dir} \
--bind ${outdir}  \
${course_dir}/containers2/TEsorter_1.3.0.sif \
TEsorter ${outdir}/gypsy.fa -db rexdb-plant -pre gypsy 

