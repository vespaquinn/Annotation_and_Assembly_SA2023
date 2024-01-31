#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --mem=20G
#SBATCH --cpus-per-task=50
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/ouEDTA-4_%j.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/erEDTA-4_%j.e
#SBATCH --partition=pall
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end
##-------------------------------------------------------------------------------
##  EDTA - The Extensive de novo TE Annotator -
## https://github.com/oushujun/EDTA
##-------------------------------------------------------------------------------

#--- setting up directories 
course_dir=/data/courses/assembly-annotation-course
work_dir=/data/users/qcoxon/annotation-SA2023/results/01-EDTA
cds_file=/data/courses/assembly-annotation-course/CDS_annotation/TAIR10_cds_20110103_representative_gene_model_updated

#--- entering work dir 
mkdir -p ${work_dir}
cd $work_dir

#---- Adding genome to work_dir 
cp /data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/assemblies/flye_polished.fasta .
genome_file=${work_dir}/flye_polished.fasta

#--- running EDTA from Singularity container 

singularity exec \
--bind ${course_dir} \
--bind ${work_dir} \
${course_dir}/containers2/EDTA_v1.9.6.sif \
EDTA.pl --genome ${genome_file} --species others --step all --cds ${cds_file} --anno 1 --threads 50
