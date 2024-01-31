#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/Canoutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/Canerror_%j.e
#SBATCH --partition=pall
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

# create data link
data=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1/pacbio

# make an assembly directory for canu 
mkdir /data/users/qcoxon/Assembl
# load the module
module load UHTS/Assembler/canu/2.1.1;

#run canu
    # -p prefix for all files and intermediates
    # -d directory in which canu will run 
canu \
   -p canu_pacbio -d /data/users/qcoxon/Assembly-SA2023/Results/Canu \
   genomeSize=125m \
   maxThreads=16 maxMemory=64 \
   -pacbio ${data}/*.fastq.gz \
   
