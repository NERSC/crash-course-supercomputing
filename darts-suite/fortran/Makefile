CC = cc
F90 = ftn
MPICC = cc
MPIF90 = ftn

OMP_FLAGS = -fopenmp
OPT_FLAGS = -g -Wall -Wextra

OBJS = darts darts-mpi darts-collective darts-omp darts-hybrid 

all: ${OBJS}

darts: darts.o
	${F90} ${OPT_FLAGS} -o darts darts.o

darts-mpi: lcgenerator.o darts-mpi.o 
	${MPIF90} ${OPT_FLAGS} -o darts-mpi darts-mpi.o lcgenerator.o

darts-collective: lcgenerator.o darts-collective.o 
	${MPIF90} ${OPT_FLAGS} -o darts-collective darts-collective.o lcgenerator.o

darts-omp: darts-omp.o
	${F90} ${OPT_FLAGS} -o darts-omp ${OMP_FLAGS} darts-omp.o

darts-hybrid: lcgenerator.o darts-hybrid.o 
	${MPIF90} ${OPT_FLAGS} -o darts-hybrid ${OMP_FLAGS} darts-hybrid.o lcgenerator.o

lcgenerator.o: lcgenerator.f90
	${MPIF90} ${OPT_FLAGS} -c lcgenerator.f90

darts.o: darts.f90
	${F90} ${OPT_FLAGS} -c darts.f90

darts-mpi.o: lcgenerator.f90 darts-mpi.f90
	${MPIF90} ${OPT_FLAGS} -c darts-mpi.f90

darts-collective.o: lcgenerator.f90 darts-collective.f90
	${MPIF90} ${OPT_FLAGS} -c darts-collective.f

darts-omp.o: darts-omp.f90
	${F90} ${OPT_FLAGS} -c darts-omp.f90

darts-hybrid.o: lcgenerator.f90 darts-hybrid.f90
	${MPIF90} ${OPT_FLAGS} -c darts-hybrid.f90

clean:
	rm -rf *.o *.mod ${OBJS}
