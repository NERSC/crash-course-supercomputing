/* Compute pi using hybrid MPI/OpenMP */
#include "lcgenerator.h"
#include <mpi.h>
#include <omp.h>
#include <stdio.h>

static long num_trials = 1000000;

int main(int argc, char **argv) {
  long i;
  long Ncirc = 0;
  double pi, x, y;
  double r = 1.0; // radius of circle
  double r2 = r*r;

  int rank, size, manager = 0;
  MPI_Status status;
  long my_trials, temp;
  int provided;

  MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &provided);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  my_trials = num_trials/size;
  if (num_trials%(long)size > (long)rank) my_trials++;
  random_last = rank;

#pragma omp parallel
{
#pragma omp for private(x,y) reduction(+:Ncirc)
  for (i = 0; i < my_trials; i++) {
#pragma omp critical (randoms)
{
    x = lcgrandom();
    y = lcgrandom();
}

    if ((x*x + y*y) <= r2)
      Ncirc++;
  }
}

  MPI_Reduce(&Ncirc, &temp, 1, MPI_LONG, MPI_SUM, manager, MPI_COMM_WORLD);

  if (rank == manager) {
    Ncirc = temp;
    pi = 4.0 * ((double)Ncirc)/((double)num_trials);
    printf("\n \t Computing pi using hybrid MPI/OpenMP: \n");
    printf("\t For %ld trials, pi = %f\n", num_trials, pi);
    printf("\n");
  } 
  MPI_Finalize();
  return 0;
}
