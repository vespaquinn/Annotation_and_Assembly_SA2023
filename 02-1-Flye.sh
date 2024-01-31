#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=FLYE-you-fools
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/Floutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/Flerror_%j.e
#SBATCH --partition=pall
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

# Go into project directory and make results directory 
cd /data/users/qcoxon/Assembly-SA2023/Results
mkdir 02-Assembly

# Create link to data directory

data=/data/courses/assembly-annotation-course/raw_data/An-1/participant_1/pacbio

# Add the Flye module
module load UHTS/Assembler/flye/2.8.3;

# Now run fly 
flye --pacbio-raw ${data}/ERR3415817.fastq.gz ${data}/ERR3415818.fastq.gz --out-dir 02-Assembly --threads 16


