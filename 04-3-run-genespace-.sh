#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=08:00:00
#SBATCH --job-name=genespace 
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/BUSCO.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/busco.e
#SBATCH --partition=pall
#-----------------------------------------------------------------------
# Setup structure 
workdir=/data/users/qcoxon/annotation-SA2023
outdir=${workdir}/results/04-genespace
genespace_script=${workdir}/scripts/04-2-genespace.R
genespace_sif=${workdir}/genespace_1.1.4.sif
mkdir -p ${outdir}
cd ${outdir}

# Run Genescape
singularity exec --bind ${workdir} ${genespace_sif} ${genespace_script}