#!/usr/bin/env bash

#SBATCH --job-name=BassSort
#SBATCH --time=06:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/testsort_%j.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/test8sort%j.e
#SBATCH --partition=pall
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

#----------------------------------------------------
## setup of directories etc.
#----------------------------------------------------

project_dir=/data/users/qcoxon/annotation-SA2023
course_dir=/data/courses/assembly-annotation-course
outdir=${project_dir}/results/01-TE
brassica=${course_dir}/CDS_annotation/Brassicaceae_repbase_all_march2019.fasta
mkdir -p ${outdir}

#----------------------------------------------------
## separating the copia and gypsy sequences from the TE library 
#----------------------------------------------------

# load seqkit 
module load UHTS/Analysis/SeqKit/0.13.2

# subset TElibrary into only the QUERY superfamily
seqkit grep -r -p Copia ${brassica} -o ${outdir}/brass_copia.fa
seqkit grep -r -p Gypsy ${brassica} -o ${outdir}/brass_gypsy.fa

#----------------------------------------------------
##  TEsorter 
#----------------------------------------------------
mkdir ${outdir}/brass_copia
cd ${outdir}/brass_copia

#--- Copia
singularity exec \
--bind ${course_dir} \
--bind ${outdir}  \
${course_dir}/containers2/TEsorter_1.3.0.sif \
TEsorter ${outdir}/brass_copia.fa -db rexdb-plant -pre brass_copia 

#--- Gypsy
mkdir ${outdir}/brass_gypsy
cd ${outdir}/brass_gypsy

singularity exec \
--bind ${course_dir} \
--bind ${outdir}  \
${course_dir}/containers2/TEsorter_1.3.0.sif \
TEsorter ${outdir}/brass_gypsy.fa -db rexdb-plant -pre brass_gypsy