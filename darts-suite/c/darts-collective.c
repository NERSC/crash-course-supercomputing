/* Compute pi using MPI collectives */
#include "lcgenerator.h"
#include <mpi.h>
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

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  my_trials = num_trials/size;
  if (num_trials%(long)size > (long)rank) my_trials++;
  random_last = rank;

  for (i = 0; i < my_trials; i++) {
    x = lcgrandom();
    y = lcgrandom();
    if ((x*x + y*y) <= r2)
      Ncirc++;
  }

  MPI_Reduce(&Ncirc, &temp, 1, MPI_LONG, MPI_SUM, manager, MPI_COMM_WORLD);

  if (rank == manager) {
    Ncirc = temp;
    pi = 4.0 * ((double)Ncirc)/((double)num_trials);
    printf("\n \t Computing pi using MPI collectives: \n");
    printf("\t For %ld trials, pi = %f\n", num_trials, pi);
    printf("\n");
  } 
  MPI_Finalize();
  return 0;
}
