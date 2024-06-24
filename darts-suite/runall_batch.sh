#!/bin/bash
#SBATCH -q regular
#SBATCH -N 1
#SBATCH -C cpu
#SBATCH -t 00:30:00
#SBATCH --reservation=crash_course     # this line only during 6/28 class 
#SBATCH -A ntrain3     # use -A mxxxx after 6/28 class if you have a regular account

# suggest to run part of the exercises from runall.sh at a time
./runall.sh
