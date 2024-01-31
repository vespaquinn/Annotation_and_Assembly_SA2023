#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/BUSCO.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/busco.e
#SBATCH --partition=pall
#-----------------------------------------------------------------------
# Setup structure 
workdir=/data/users/qcoxon/annotation-SA2023
outdir=${workdir}/results/03-BUSCO
input=${workdir}/results/03-maker/pilon_flye.maker.output.renamed/pilon_flye.all.maker.proteins.fasta.renamed.fasta
mkdir -p ${outdir}
cd ${outdir}

# Get the config for augustus
cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
export AUGUSTUS_CONFIG_PATH=./augustus_config

# load the module
module load Blast/ncbi-blast/2.10.1+

# Run BUSCO 
busco -i ${input} -l brassicales_odb10 -o BUSCO -m proteins -c 16
        # -i: input file
        # -l: lineage specification
        # -o: name for output folder
        # -m: analysis mode
        # -c: number of cpus

# Generate plots
python3 10_b_generate_busco_plots.py -wd ${outdir}