#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=4
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/sam2bam-xoutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/bamsort3_xerror_%j.e
#SBATCH --partition=pall
#SBATCH --job-name=bamsort
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

# create data link
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing

# Load the bowtie and samtools modules
module load UHTS/Analysis/samtools/1.10

# now convert the .sam output to a .bam file

# samtools view -bo ${outdir}/illumina_flyaligned.bam ${outdir}/flye/illuminaflyaligned.sam

#---- sorting ----

#samtools sort ${outdir}/flye/illumina_flyaligned.bam -o ${outdir}/flye/flye_sorted.bam

samtools sort ${outdir}/canu/illumina_canualigned.bam -o ${outdir}/canu/canu_sorted.bam

#---- indexing ----
