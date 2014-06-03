#!/bin/bash

#
# Script to run your darts codes for all possible iterations on one node
#
# Run this script in an interactive job, e.g.,
# qsub -I -W group_list=courses01 -lwalltime=1:00:00,nodes=1:ppn=12 -X -V
#

EXECS="darts-mpi darts-collective darts-omp darts-hybrid"
# You will need to change the name of the directory where your code is
MYDIR=/home/rebecca/training/2012-10/fortran
#MYDIR=/home/rebecca/training/2012-10/c

# Also change the scratch directory
MYSCRATCH=/scratch/director100/rebecca/

for f in ${EXECS};
do
    cp ${MYDIR}/$f ${MYSCRATCH}
done

echo 'Simple MPI'
for i in `seq 1 12`;
do
    echo
    echo 'mpirun -np' $i './darts-mpi'
    mpirun -np $i ./darts-mpi
done

echo
echo 'MPI collectives'
for i in `seq 1 12`;
do
    echo
    echo 'mpirun -np' $i './darts-collective'
    mpirun -np $i ./darts-collective
done

echo
echo 'OpenMP only'
for i in `seq 1 12`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i './darts-mpi'
    export OMP_NUM_THREADS=$i 
    ./darts-omp
done

echo
echo 'Hybrid'
for i in `seq 1 12`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i 'mpirun -np 1 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    mpirun -np 1 ./darts-hybrid
done

for i in `seq 1 6`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i 'mpirun -np 2 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    mpirun -np 2 ./darts-hybrid
done

for i in `seq 1 4`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i 'mpirun -np 3 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    mpirun -np 3 ./darts-hybrid
done

for i in `seq 1 3`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i 'mpirun -np 4 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    mpirun -np 4 ./darts-hybrid
done

for j in `seq 5 6`;
do
    for i in `seq 1 2`;
    do
        echo
        echo 'OMP_NUM_THREADS =' $i 'mpirun -np' $j './darts-hybrid'
        mpirun -np $j ./darts-hybrid
    done
done

echo 'Done testing'
