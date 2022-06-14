#!/bin/bash
#SBATCH -q regular
#SBATCH -N 1
#SBATCH -C knl
#SBATCH -t 00:30:00
#SBATCH --reservation=res_name
#SBATCH -A ntrainN

# suggest to run part of the exercises from runall.sh at a time
./runall.sh
