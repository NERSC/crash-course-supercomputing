#!/bin/bash

#
# Script to run your darts codes for all possible iterations on one node
#
# Run this script in an interactive job, e.g.,
# salloc -t 00:30:00 -N 1 -q debug
#

EXECS="darts-mpi darts-collective darts-omp darts-hybrid"
# You will need to change the name of the directory where your code is, such as in $HOME or $SCRATCH
MYDIR=$HOME/crash-course-supercomputing/darts-suite/c
#MYDIR=$HOME/crash-course-supercomputing/darts-suite/fortran
#MYDIR=$SCRATCH/crash-course-supercomputing/darts-suite/c
#MYDIR=$SCRATCH/crash-course-supercomputing/darts-suite/fortran
MPIRUN=srun

# Also change the scratch directory
MYSCRATCH=$SCRATCH

for f in ${EXECS};
do
    cp ${MYDIR}/$f ${MYSCRATCH}
done

cd ${MYSCRATCH}

echo 'Simple MPI'
for i in `seq 1 12`;
do
    echo
    echo $MPIRUN ' -n' $i './darts-mpi'
    time $MPIRUN -n $i ./darts-mpi
done

echo
echo 'MPI collectives'
for i in `seq 1 12`;
do
    echo
    echo $MPIRUN ' -n' $i './darts-collective'
    time $MPIRUN -n $i ./darts-collective
done

echo
echo 'OpenMP only'
for i in `seq 1 12`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i './darts-mpi'
    export OMP_NUM_THREADS=$i 
    time ./darts-omp
done

echo
echo 'Hybrid'
for i in `seq 1 12`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i $MPIRUN ' -n 1 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    time $MPIRUN -n 1 ./darts-hybrid
done

for i in `seq 1 6`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i $MPIRUN ' -n 2 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    time $MPIRUN -n 2 ./darts-hybrid
done

for i in `seq 1 4`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i $MPIRUN ' -n 3 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    time $MPIRUN -n 3 ./darts-hybrid
done

for i in `seq 1 3`;
do
    echo
    echo 'OMP_NUM_THREADS =' $i $MPIRUN ' -n 4 ./darts-hybrid'
    export OMP_NUM_THREADS=$i 
    time $MPIRUN -n 4 ./darts-hybrid
done

for j in `seq 5 6`;
do
    for i in `seq 1 2`;
    do
        echo
        echo 'OMP_NUM_THREADS =' $i $MPIRUN ' -n' $j './darts-hybrid'
        time $MPIRUN -n $j ./darts-hybrid
    done
done

echo 'Done testing'
