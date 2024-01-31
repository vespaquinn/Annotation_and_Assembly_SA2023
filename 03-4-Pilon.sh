#!/usr/bin/env bash

#SBATCH --time=20:00:00
#SBATCH --mem=48G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/Poutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/Pil4error_%j.e
#SBATCH --partition=pall
#SBATCH --job-name=Pilon_canu
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end

#mkdir /data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/pilon
outdir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/pilon
#---------------------------------------------
# CANU #
data_fasta=/data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/canu/canu_pacbio.contigs.fasta
index=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/canu/canu_sorted.bam

# run Pilon 
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
--genome ${data_fasta} --frags ${index} --output canu_polished --outdir ${outdir} --diploid --fix "all" --threads 16

#---------------------------------------------
# flye #
data_fasta=/data/users/qcoxon/Assembly-SA2023/Results/02-Assembly/flye/assembly.fasta
index=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/flye/flye_sorted.bam

# run Pilon 
java -Xmx45g -jar /mnt/software/UHTS/Analysis/pilon/1.22/bin/pilon-1.22.jar \
--genome ${data_fasta} --frags ${index} --output flye_polished --outdir ${outdir} --diploid --fix "all" --threads 16

#---------------------------------------------
# Cleanup
#---------------------------------------------
# Create a directory containing the polished and unpolished assemblies labelled in a logical and consistent way 
# to allow their use downstream 
assemblies_dir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/assemblies
unpolished_dir=/data/users/qcoxon/Assembly-SA2023/Results/02-Assembly
mkdir ${assemblies_dir}

# 1. unpolished flye
mv ${unpolished_dir}/flye/assembly.fasta ${assemblies_dir}/flye_unpolished.fasta 
# 2. unpolished canu
mv ${unpolished_dir}/canu/canu_pacbio.contigs.fasta ${assemblies_dir}/canu_unpolished.fasta 
# 3. 'polished' trinity  (labelled polished as the trinity assembler undertakes polishing autonomously)
mv ${unpolished_dir}/trinity/Trinity.fasta ${assemblies_dir}/trinity_polished.fasta
# 4. polished flye
mv ${outdir}/flye_polished.fasta ${assemblies_dir}/flye_polished.fasta
# 5. polished canu
mv ${outdir}/canu_polished.fasta ${assemblies_dir}/canu_polished.fasta
