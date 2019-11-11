#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-user=briana.oshiro@uconn.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=1:00:00    
#SBATCH -e error_run_feat_%a.log    
#SBATCH -o output_run_feat_%a.log
#SBATCH --job-name=run_feat_%a
#SBATCH --partition=serial
##### END OF JOB DEFINITION  #####


module load singularity
unset LD_PRELOAD
singularity run \
--bind /scratch/psyc5171/$USER/f19-ex6/scripts:/input \
--bind /scratch/psyc5171/$USER/f19-ex6/derivatives:/output \
/scratch/psyc5171/containers/hcpbids_4.0.sif \
/input/flame.sh

