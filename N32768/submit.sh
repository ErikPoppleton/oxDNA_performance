#!/bin/bash -l
# Standard output and error:
#SBATCH -o ./job.%j.out
#SBATCH -e ./job.%j.err
# Initial working directory:
# Job name
#SBATCH -J N32768
#
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --constraint="gpu"
#
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10000
#
#SBATCH --time=1-00:00:00

module purge
module load cuda/11.4

~/software/oxDNA/build/bin/oxDNA input
