#!/usr/bin/env bash

#SBATCH --time=02:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/bt2-3output_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/sam2bam-3error_%j.e
#SBATCH --partition=pall
#SBATCH --job-name=sam2bam
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

# create data links
illumina_reads=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1/Illumina
cd /data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/flye
 
# create and enter the polishing directory and flye subdirectory 
#mkdir /data/users/qcoxon/Assembly-SA2023/Results/03-Polishing 
#mkdir /data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/flye
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/flye

# Load the bowtie and samtools modules
module load UHTS/Aligner/bowtie2/2.3.4.1 

    # --local option, bt2 allows trimming of read characters from one or both ends of the alignment to maximize the alignment score
    # -x specifies basename of index for reference genome
    # -1 and -2 specify the two directions of the reads we want to align 
        # NB. here they are compresses so we use zcat 
    # - S specifies the name of the SAM output file
#bowtie2 --sensitive-local -p 8 -x flindex -1 <(zcat ${illumina_reads}/ERR3624579_1.fastq.gz) -2 <(zcat ${illumina_reads}/ERR3624579_2.fastq.gz) -S ${outdir}/illumina_flyaligned.sam

# now convert the .sam output to a .bam file

samtools view -bo ${outdir}/illumina_flyaligned.bam ${outdir}/illumina_flyaligned.sam 

# then sort this bam file 
samtools sort -m 5G -@ 4 ${outdir}/illumina_flyaligned.bam -o ${outdir}/flye_sorted.bam

#--------------------------------------------------------------------------------------------------------------------------------------------
# REPEAT THE PROCESS FOR CANU
cd /data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/canu
 
# create and enter the polishing directory and flye subdirectory 
#mkdir /data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/canu
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/canu

# align the reads
#bowtie2 --sensitive-local -p 8 -x canindex -1 <(zcat ${illumina_reads}/ERR3624579_1.fastq.gz) -2 <(zcat ${illumina_reads}/ERR3624579_2.fastq.gz) -S ${outdir}/illumina_canualigned.sam

