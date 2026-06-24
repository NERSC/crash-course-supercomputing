CC       = cc
FC       = ftn
MPICC    = cc
MPIF90   = ftn

OMP_FLAGS  = -fopenmp
OPT_FFLAGS = -O3 -Wall -Wextra

TARGETS = darts \
          darts-omp \
          darts-omp-loop \
          darts-mpi \
          darts-collective \
          darts-hybrid

.PHONY: all clean

all: $(TARGETS)

darts: lcgenerator.o darts.f90
	$(FC) $(OPT_FLAGS) $^ -o $@

darts-omp: lcgenerator.o darts-omp.f90
	$(FC) $(OPT_FLAGS) $(OMP_FLAGS) $^ -o $@

darts-omp-loop: lcgenerator.o darts-omp-loop.f90
	$(FC) $(OPT_FLAGS) $(OMP_FLAGS) $^ -o $@

darts-mpi: lcgenerator.o darts-mpi.f90
	$(MPIF90) $(OPT_FLAGS) $^ -o $@

darts-collective: lcgenerator.o darts-collective.f90
	$(MPIF90) $(OPT_FLAGS) $^ -o $@

darts-hybrid: lcgenerator.o darts-hybrid.f90
	$(MPIF90) $(OPT_FLAGS) $(OMP_FLAGS) $^ -o $@

lcgenerator.o: lcgenerator.f90
	$(FC) $(OPT_FLAGS) -c $< -o $@

clean:
	rm -f $(TARGETS) *.o *.mod
