#!/usr/bin/env bash

#SBATCH --time=06:00:00
#SBATCH --mem=12G
#SBATCH --cpus-per-task=4
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/sam2bam-xoutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/bamsort3_xerror_%j.e
#SBATCH --partition=pall
#SBATCH --job-name=bamsort
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

#--------------------------------------------------------------------------------------------------------------------------------------------
# FOR CANU
cd /data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/canu
 
# enter the polishing directory and canu subdirectory 
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/canu

# Load the bowtie module
module load UHTS/Analysis/samtools/1.10

# SAM to BAM 
samtools view -bo ${outdir}/illumina_canualigned.bam ${outdir}/illumina_canualigned.sam 

# then sort this bam file 
samtools sort -m 5G -@ 4 ${outdir}/illumina_canualigned.bam -o ${outdir}/canu_sorted.bam

# and index it 
samtools index ${outdir}/canu/canu_sorted.bam

#--------------------------------------------------------------------------------------------------------------------------------------------
# FOR FLYE
cd /data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/flye
 
# enter the polishing directory and flye subdirectory 
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/flye

# SAM to BAM 
samtools view -bo ${outdir}/illumina_flyealigned.bam ${outdir}/illumina_flyealigned.sam 

# then sort this bam file 
samtools sort -m 5G -@ 4 ${outdir}/illumina_flyealigned.bam -o ${outdir}/flye_sorted.bam

# and index it 
samtools index ${outdir}/flye/flye_sorted.bam


