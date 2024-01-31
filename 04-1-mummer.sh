#!/usr/bin/env bash
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name=mummer
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/mumoutput_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/mumerror%j.e
#SBATCH --cpus-per-task=8
#SBATCH --mem=60G
#SBATCH --time=08:00:00
#SBATCH --partition=pall

## -------------------------------------------------------------------
## Nucmer
##--------------------------------------------------------------------

#Setup directories and such
project_dir=/data/users/qcoxon/Assembly-SA2023
data_dir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/assemblies
outdir=${project_dir}/Results/04-comparison/mummer
ref_gen=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
mkdir -p ${outdir}
cd ${outdir}

# Load module
module load UHTS/Analysis/mummer/4.0.0beta1

# Run Flye vs. ref_gen
nucmer -b 1000 -c 1000 -p flye ${ref_gen} ${data_dir}/flye_polished.fasta
        #-b: extension before giving in poor regions
        #-c: minimum cluster length
        #-p: name for the output files

# Run Canu vs. ref_gen
nucmer -b 1000 -c 1000 -p canu ${ref_gen} ${data_dir}/canu_polished.fasta

# Run Flye vs. Canu
nucmer -b 1000 -c 1000 -p flye_canu ${data_dir}/flye_polished.fasta ${data_dir}/canu_polished.fasta

## -------------------------------------------------------------------
## Mummer
##--------------------------------------------------------------------

# Run mummer for Flye, Canu and the reference genome

# Ref vs Flye
mummerplot -R ${ref_gen} -Q ${data_dir}/flye_polished.fasta -f -t png -s large -l -p ref_flye ${outdir}/flye.delta

# Ref vs Canu
mummerplot -R ${ref_gen} -Q ${data_dir}/canu_polished.fasta -f -t png -s large -l -p ref_canu ${outdir}/canu.delta

# Flye vs Canu
mummerplot -R ${data_dir}/flye_polished.fasta -Q ${data_dir}/canu_polished.fasta -f -t png -s large -l -p flye_canu ${outdir}/flye_canu.deltaq