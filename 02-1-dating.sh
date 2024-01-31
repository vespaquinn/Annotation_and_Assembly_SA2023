#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=dating
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/dating6_%j.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/DATING6_%j.e
#SBATCH --partition=pall
##-------------------------------------------------------------------------------
##  Parsing Repeat Masker Outputs - TE Dating
## https://github.com/4ureliek/Parsing-RepeatMasker-Outputs
##-------------------------------------------------------------------------------
# - 0 --- * Setting up directories and all that jazz  * ---
workdir=/data/users/qcoxon/annotation-SA2023
outdir=${workdir}/results/02-dating
input=${workdir}/results/01-EDTA/flye_polished.fasta.mod.EDTA.anno/flye_polished.fasta.mod.out

mkdir -p ${outdir}
cd ${outdir}

# getting the perl script from github 
wget https://raw.githubusercontent.com/4ureliek/Parsing-RepeatMasker-Outputs/master/parseRM.pl

#- 1 --- * Conda Environment * ---
    # NB the installation steps were undertaken in an interactive shell and are commented out here
    # cannot guarantee they work in a batch script 
module load Conda/miniconda/3 
eval "$(conda shell.bash hook)" # NB. this line is needed for using conda environments in batch scripts, see https://hpc-unibe-ch.github.io/software/Anaconda.html#move-migration-of-conda-environments 
    #conda create -n dating_env
conda activate dating_env
    #conda install -c bioconda perl-bioperl

# - 2 --- * Splitting DNA by bins of divergence * 
perl parseRM.pl -i ${input} -l 50,1 -v
        # -i: define input file
        # -l: what amount of divergence or Myr to split the DNA amount on
        # -v: verbose mode

conda deactivate 

# - 3 --- remove 1st and 3rd lines from outfile
outfile=polished.fasta.Rname.tab
sed '1d;3d' ${outfile} > polished.fasta.Rname.tab