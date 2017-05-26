#!/bin/bash -l
#SBATCH --job-name=hostname
#SBATCH --account=courses01
#SBATCH --reservation=courseq
#SBATCH --nodes=2
#SBATCH --time=00:05:00
#SBATCH --export=NONE

echo "/bin/hostname"
#To launch job on the service (MOM) node - CAREFUL
/bin/hostname

echo "aprun -n 48 -N 24 /bin/hostname"
#To launch job on the allocated compute nodes
aprun -n 48 -N 24 /bin/hostname
