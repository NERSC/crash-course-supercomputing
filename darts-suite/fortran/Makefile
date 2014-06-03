CC = icc
F90 = ifort
MPICC = mpicc
MPIF90 = mpif90

OMP_FLAGS = -openmp
OPT_FLAGS = -g

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

lcgenerator.o: lcgenerator.f
	${MPIF90} ${OPT_FLAGS} -c lcgenerator.f

darts.o: darts.f
	${F90} ${OPT_FLAGS} -c darts.f

darts-mpi.o: lcgenerator.f darts-mpi.f
	${MPIF90} ${OPT_FLAGS} -c darts-mpi.f

darts-collective.o: lcgenerator.f darts-collective.f
	${MPIF90} ${OPT_FLAGS} -c darts-collective.f

darts-omp.o: darts-omp.f
	${F90} ${OPT_FLAGS} -c darts-omp.f

darts-hybrid.o: lcgenerator.f darts-hybrid.f
	${MPIF90} ${OPT_FLAGS} -c darts-hybrid.f

clean:
	rm -rf *.o *.mod ${OBJS}
