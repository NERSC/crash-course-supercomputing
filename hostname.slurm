#!/bin/bash -l
#SBATCH --job-name=hostname
#SBATCH --account=courses01
#SBATCH --reservation=courseq
#SBATCH --nodes=2
#SBATCH --time=00:05:00
#SBATCH --export=NONE

echo "/bin/hostname"
#To launch job on the service job 
/bin/hostname

echo "aprun -n 48 -N 24 /bin/hostname"
#To launch job on the requested compute nodes
aprun -n 48 -N 24 /bin/hostname
