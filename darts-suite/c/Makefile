CC = cc
F90 = ftn
MPICC = cc
MPIF90 = ftn

OMP_FLAGS = -fopenmp 
OPT_FLAGS = -g -Wall -Wextra -ansi

OBJS = darts darts-mpi darts-collective darts-omp darts-hybrid

all: ${OBJS}

darts: darts.o lcgenerator.h
	${CC} ${OPT_FLAGS} -o darts darts.o

darts-mpi: darts-mpi.o lcgenerator.h
	${MPICC} ${OPT_FLAGS} -o darts-mpi darts-mpi.o

darts-collective: darts-collective.o lcgenerator.h
	${MPICC} ${OPT_FLAGS} -o darts-collective darts-collective.o

darts-omp: darts-omp.o lcgenerator.h
	${CC} ${OPT_FLAGS} -o darts-omp ${OMP_FLAGS} darts-omp.o

darts-hybrid: darts-hybrid.o lcgenerator.h
	${MPICC} ${OPT_FLAGS} -o darts-hybrid ${OMP_FLAGS} darts-hybrid.o

darts-mpi.o: darts-mpi.c
	${MPICC} ${OPT_FLAGS} -c darts-mpi.c

darts-collective.o: darts-collective.c
	${MPICC} ${OPT_FLAGS} -c darts-collective.c

darts-omp.o: darts-omp.c
	${CC} ${OPT_FLAGS} ${OMP_FLAGS} -c darts-omp.c

darts-hybrid.o: darts-hybrid.c
	${MPICC} ${OPT_FLAGS} ${OMP_FLAGS} -c darts-hybrid.c

clean:
	rm -rf *.o ${OBJS}
