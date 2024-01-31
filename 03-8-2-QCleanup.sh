#!/usr/bin/env bash
#SBATCH --mail-user=quinn.coxon@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --job-name=QUAST-5
#SBATCH --output=/data/users/qcoxon/Assembly-SA2023/Outputs/quoutput5_%j.o
#SBATCH --error=/data/users/qcoxon/Assembly-SA2023/Errors/querror5%j.e
#SBATCH --cpus-per-task=24
#SBATCH --mem=60G
#SBATCH --time=08:00:00
#SBATCH --partition=pall

### RUN THIS SCRIPT 5 TIMES -------------
### RUNS COMPLETE 5/5       -------------

# Establish which run this is (polished/unpolished, flye/canu/trinity)
    # 1. polished flye; 2. unpolished flye; 3. polished canu; 4. unpolished canu; 5. polished trinity 
    #NB. trinity is classed as 'polished' since it undertakes polishing itself

## -------- !! NB !! CHANGE THESE TWO VARIABLES FOR EACH RUN !! ------
polishing=polished
assembler=flye 
## -------------------------------------------------------------------

#Setup directories
project_dir=/data/users/qcoxon/Assembly-SA2023
data_dir=/data/users/qcoxon/Assembly-SA2023/Results/03-Polishing/assemblies
outdir=${project_dir}/Results/03-Polishing/quast/without_reference/${assembler}_${polishing}
ref_dir=/data/courses/assembly-annotation-course/references
mkdir -p ${outdir}

#Setup QUAST variables 
assembly=${data_dir}/${assembler}_${polishing}.fasta
name=${assembler}_${polishing}


#--------------------------------------------------------------------------------------------------------------------------
    # With reference
#------------------------
module add UHTS/Quality_control/quast/4.6.0

outdir=${project_dir}/Results/03-Polishing/quast/with_reference/${assembler}_${polishing}
mkdir -p ${outdir}
    #run QUAST with reference 
        python /software/UHTS/Quality_control/quast/4.6.0/bin/quast.py -o ${outdir} -R ${ref_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa -m 3000 -t 24 -l ${name} -e --est-ref-size 125000000 -i 500 -x 7000 ${assembly}
            #Options entered here are:
                #"-o": Directory to store all result files
                #"-R": Reference genome file
                #"-m": Lower threshold for contig length.
                #"-t": Maximum number of threads
                #"-l": Human-readable assembly names. Those names will be used in reports, plots and logs.
                #"-e": Genome is eukaryotic. Affects gene finding, conserved orthologs finding and contig alignment.
                #"--est-ref-size": Estimated reference size
                #"-i": the minimum alignment length
                #"-x": Lower threshold for extensive misassembly size. All relocations with inconsistency less than extensive-mis-size are counted as local misassemblies

