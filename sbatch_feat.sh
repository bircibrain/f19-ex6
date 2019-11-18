#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=2:00:00    
#SBATCH -e error_%A_%a.log    
#SBATCH -o output_%A_%a.log
#SBATCH --partition=serial



module load singularity

unset LD_PRELOAD

singularity run \
--bind /scratch/psyc5171/$USER/hw6:/input \
/scratch/psyc5171/containers/hcpbids_4.0.sif \
/input/scripts/flame_feat.sh 