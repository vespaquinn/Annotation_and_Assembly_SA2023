#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=12G
#SBATCH --time=0-20:00:00
#SBATCH --job-name=maker
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/qcoxon/annotation-SA2023/errorout/MAKER.o
#SBATCH --error=/data/users/qcoxon/annotation-SA2023/errorout/maker.e
#SBATCH --partition=pall
##-------------------------------------------------------------------------------
## 
## NB. RUN THREE TIMES, ONCE TO CREATE EMPTY CONTROL FILES, ONCE TO RUN MAKER, AND ONCE TO REMAP IDs 
## COMMENT OUT RELEVENT CODE
##-------------------------------------------------------------------------------
# Add modules
module add SequenceAnalysis/GenePrediction/maker/2.31.9

# Define directory and file shortcuts
coursedir=/data/courses/assembly-annotation-course
softdir=/software
workdir=/data/users/qcoxon/annotation-SA2023
outdir=${workdir}/results/03-maker
mkdir -p ${outdir}
cd ${outdir}

# ---- RUN 1 ----
## Create control files
#singularity exec \
#--bind $SCRATCH \
#--bind ${coursedir} \
#--bind ${workdir} \
#--bind ${softdir} \
#${coursedir}/containers2/MAKER_3.01.03.sif \
#maker -CTL #create empty control files

# ---- RUN 2 ----
## Run maker with mpi singularity
#mpiexec -n 16 singularity exec \
#--bind $SCRATCH \
#--bind ${coursedir} \
#--bind ${workdir} \
#--bind ${softdir} \
#${coursedir}/containers2/MAKER_3.01.03.sif \
#maker -mpi maker_opts.ctl maker_bopts.ctl maker_exe.ctl

# ---- RUN 3 ----
# abbreviate the input file
input=${outdir}/pilon_flye.maker.output/pilon_flye_master_datastore_index.log

# Create the fasta and gff files
gff3_merge -d ${input} -o pilon_flye.all.maker.gff
        ## -d: path to input file
        ## -o: name of output file

gff3_merge -d ${input} -o pilon_flye.all.maker.noseq.gff
        ## -n: do not print fasta seq in footer
        ## -d: path to input file
        ## -o: name of output file
fasta_merge -d ${input} -o pilon_flye
        ## -d: path to input file
        ## -o: name of output file

# Finish the annotation 
    ##(renaming MAKER genes and building shorter IDs)
# set variables
protein=pilon_flye.all.maker.proteins.fasta
transcript=pilon_flye.all.maker.transcripts.fasta
gff=pilon_flye.all.maker.noseq.gff

# shorten names
cp $gff ${gff}.renamed.gff
cp $protein ${protein}.renamed.fasta
cp $transcript ${transcript}.renamed.fasta

# use maker map ids to map the IDs onto the new files 
maker_map_ids --prefix pilon_flye --justify 7 ${GFF}.renamed.gff > pilon_flye.id.map
        ## --prefix tag used for all ids
        ## --justify unique integer portion of the ID will be right justified with '0's to this length 
        ## (default = 8)

map_gff_ids pilon_flye.id.map ${gff}.renamed.gff
map_fasta_ids pilon_flye.id.map ${protein}.renamed.fasta
map_fasta_ids pilon_flye.id.map ${transcript}.renamed.fasta