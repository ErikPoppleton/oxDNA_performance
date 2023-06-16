#!/bin/bash -l
# Standard output and error:
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err

# Job Name:
#SBATCH -J NstrandsMproc

# Number of nodes and MPI tasks per node:
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c proc

# Request say 10 GB of main Memory per node in Units of MB:
#SBATCH --mem=80000

# GPU stuff
#SBATCH --constraint="gpu"
#SBATCH --nvmps
#SBATCH --gres=gpu:1

# Wall clock limit:
#SBATCH --time=24:00:00

module purge
module load gcc/10 cuda/11.4
nvidia-cuda-mps-control -d
for i in $(seq 1 proc); do
cd r$i
timeout 23.9h /u/epoppleton/software/oxDNA/build/bin/oxDNA input &
sleep 0.25
cd ..
done
sleep 3
nvidia-smi
wait
echo quit | nvidia-cuda-mps-control
