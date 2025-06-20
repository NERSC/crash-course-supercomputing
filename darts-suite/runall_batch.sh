#!/bin/bash
#SBATCH -q regular    # can also use -q debug for faster queue turnaround
#SBATCH -N 1
#SBATCH -C cpu
#SBATCH -t 00:30:00
#SBATCH --reservation=crash_course     # this line only during the live class 
#SBATCH -A trn012    # use -A mxxxx after class if you have a regular account

# suggest to run part of the exercises from runall.sh at a time
./runall.sh
