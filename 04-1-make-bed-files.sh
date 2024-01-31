#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=01:00:00
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
input_fasta=${workdir}/results/03-maker/pilon_flye.maker.output.renamed/pilon_flye.all.maker.proteins.fasta.renamed.fasta
input_gff=${workdir}/results/03-maker/pilon_flye.maker.output.renamed/pilon_flye.maker.output.renamed/pilon_flye.all.maker.noseq.gff.renamed.gff
mkdir -p ${outdir}
cd ${outdir}

# Load seqkit module
module load UHTS/Analysis/SeqKit/0.13.2

# Sort contigs by size
awk '$3=="contig"' ${input_gff} | sort -t $'\t' -k5 -n -r > ${outdir}/Cvi_0_size_sorted_contigs.txt

# 10 longest contigs
head -n10 ${outdir}/Cvi_0_size_sorted_contigs.txt | cut -f1 > ${outdir}/Cvi_0_contigs.txt

# Create bed file
awk '$3=="mRNA"' ${input_gff} | cut -f 1,4,5,9 | sed 's/ID=//' | sed 's/;.\+//' | grep -w -f ${outdir}/Cvi_0_contigs.txt > ${outdir}/bed/Cvi_0.bed

# Gene IDs
cut -f4 ${outdir}/bed/Cvi_0.bed > ${outdir}/Cvi_0_gene_IDs.txt

# Fasta file
cat ${input_fasta} | seqkit grep -r -f ${outdir}/Cvi_0_gene_IDs.txt | seqkit seq -i > ${outdir}/peptide/Cvi_0.fa
