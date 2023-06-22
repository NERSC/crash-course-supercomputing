#!/bin/bash
#SBATCH -q regular
#SBATCH -N 1
#SBATCH -C cpu
#SBATCH -t 00:30:00
#SBATCH --reservation=crash_course     # this line only during 6/22 class 
#SBATCH -A ntrain5         # or -A ntrain3 if you have an account from 6/8 class
		      # use -A mxxxx after 6/22 class if you have a regular account

# suggest to run part of the exercises from runall.sh at a time
./runall.sh
