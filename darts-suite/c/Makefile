CC = cc
F90 = ftn
MPICC = cc
MPIF90 = ftn

OMP_FLAGS = -fopenmp 
OPT_FLAGS = -g  -O0 -Wall -Wextra -std=c99

OBJS = darts darts-mpi darts-collective darts-omp darts-omp-loop darts-hybrid

all: ${OBJS}

darts: darts.o
	${CC} ${OPT_FLAGS} -o darts darts.o

darts-mpi: darts-mpi.o
	${MPICC} ${OPT_FLAGS} -o darts-mpi darts-mpi.o

darts-collective: darts-collective.o
	${MPICC} ${OPT_FLAGS} -o darts-collective darts-collective.o

darts-omp: darts-omp.o
	${CC} ${OPT_FLAGS} -o darts-omp ${OMP_FLAGS} darts-omp.o

darts-omp-loop: darts-omp-loop.o 
	${CC} ${OPT_FLAGS} -o darts-omp-loop ${OMP_FLAGS} darts-omp-loop.o

darts-hybrid: darts-hybrid.o
	${MPICC} ${OPT_FLAGS} -o darts-hybrid ${OMP_FLAGS} darts-hybrid.o

darts.o: darts.c lcgenerator.h
	${CC} ${OPT_FLAGS} -c darts.c

darts-mpi.o: darts-mpi.c lcgenerator.h
	${MPICC} ${OPT_FLAGS} -c darts-mpi.c

darts-collective.o: darts-collective.c lcgenerator.h
	${MPICC} ${OPT_FLAGS} -c darts-collective.c

darts-omp.o: darts-omp.c lcgenerator.h
	${CC} ${OPT_FLAGS} ${OMP_FLAGS} -c darts-omp.c

# If darts-omp-loop includes lcgenerator.h, keep it explicitly matched here
darts-omp-loop.o: darts-omp-loop.c lcgenerator.h
	${CC} ${OPT_FLAGS} ${OMP_FLAGS} -c darts-omp-loop.c

darts-hybrid.o: darts-hybrid.c lcgenerator.h
	${MPICC} ${OPT_FLAGS} ${OMP_FLAGS} -c darts-hybrid.c

clean:
	rm -rf *.o ${OBJS}
