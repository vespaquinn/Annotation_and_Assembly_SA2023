#!/usr/bin/env bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --job-name=blast
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/BUSCO.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/busco.e
#SBATCH --partition=pall
#-----------------------------------------------------------------------
# Setup structure 
workdir=/data/users/qcoxon/annotation-SA2023
outdir=${workdir}/results/03-blast
input=${workdir}/results/03-maker/pilon_flye.maker.output.renamed/pilon_flye.all.maker.proteins.fasta.renamed.fasta
blastdir=${outdir}/blast
uniprotdb=/data/courses/assembly-annotation-course/CDS_annotation/MAKER/uniprot_viridiplantae_reviewed.fa
mkdir -p ${outdir}
mkdir -p ${blastdir}
cd ${outdir}

# Load module
module load Blast/ncbi-blast/2.10.1+

# create the blast database from uniprot data (found in course dir)
makeblastdb -in ${uniprotdb} -dbtype prot -out ${blastdir}/uniprot.db
        # -in: uniprot reviewed data
        # -dbtype: type of database
        # -out: output directory and file name
# run BLAST
blastp -query ${input} -db ${blastdir}/uniprot.db -num_threads 30 -outfmt 6 -evalue 1e-10 -out ${outdir}/blastp.out
