#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --job-name=phylogeny-gypsy
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/PHYLO_%j.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/phylo_%j.e
#SBATCH --partition=pall
##-------------------------------------------------------------------------------
## 
##-------------------------------------------------------------------------------
# NB. !!! CHANGE VARIABLES FOR COPIA AND GYPSY RUNS !!!
#--- GYPSY RUN
element_type=gypsy
prot_seq=Ty3-RT
# COPIA RUN
    #element_type=copia
    #prot_seq=Ty1-RT

# - 0 --- * Setting up directories and loading modules(and all that jazz)  * ---
# directories
workdir=/data/users/qcoxon/annotation-SA2023
outdir=${workdir}/results/02-phylogeny
input=${workdir}/results/01-TE-Arabadopsis/${element_type}.dom.faa

mkdir -p ${outdir}
cd ${outdir}

# modules
module load UHTS/Analysis/SeqKit/0.13.2
module load SequenceAnalysis/MultipleSequenceAlignment/clustal-omega/1.2.4
module load Phylogeny/FastTree/2.1.10

# - 1 --- * Extracting the protein sequences from the .dom.faa format * ---
grep ${element_type} ${input} > ${element_type}_list.txt
sed -i 's/>//' ${element_type}_list.txt #remove '>' headers
sed -i 's/ .\+//' ${element_type}_list.txt #remove characters following an empty space
seqkit grep -f ${element_type}_list.txt ${input} -o ${element_type}_RT.fasta
        # -f: pattern file
        # -o: outputfile

# shorten the identifiers of RT sequences
# Shorten identifiers
sed -i 's/|.\+//' ${element_type}_RT.fasta 
    # removes all characters after "|"

# - 2 --- * Aligning the sequences with clustalo
clustalo -i ${element_type}_RT.fasta -o ${element_type}_protein_alignment.fasta
        # -i: multiple sequence input file
        # -o: alignment output file

 # - 3 --- * Creating the phylogenetic tree with Fast Tree 
FastTree -out ${element_type}_protein_alignment.tree ${element_type}_protein_alignment.fasta