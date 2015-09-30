/* Compute pi using MPI and threaded MKL for random number generator */
#include <mpi.h>
#include <mkl_vsl.h>
#include <stdio.h>

static long num_trials = 1000000;

int main(int argc, char **argv) {
  long i;
  long Ncirc = 0;
  double pi, xy[2];
  double r = 1.0; // radius of circle
  double r2 = r*r;

  int rank, size, manager = 0;
  MPI_Status status;
  long my_trials, temp;
  int j;

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  VSLStreamStatePtr stream;

  my_trials = num_trials/size;
  if (num_trials%(long)size > (long)rank) my_trials++;

  vslNewStream(&stream, VSL_BRNG_MT2203+rank, 1);

  for (i = 0; i < my_trials; i++) {
    vdRngUniform(VSL_RNG_METHOD_UNIFORMBITS_STD, stream, 2, xy, 0.0, 1.0);
    if ((xy[0]*xy[0] + xy[1]*xy[1]) <= r2)
      Ncirc++;
  }

  if (rank == manager) {
    for (j = 1; j < size; j++) {
      MPI_Recv(&temp, 1, MPI_LONG, j, j, MPI_COMM_WORLD, &status);
      Ncirc += temp;
    }
    pi = 4.0 * ((double)Ncirc)/((double)num_trials);
    printf("\n \t Computing pi using MPI and threaded MKL for random number generator: \n");
    printf("\t For %ld trials, pi = %f\n", num_trials, pi);
    printf("\n");
  } else {
    MPI_Send(&Ncirc, 1, MPI_LONG, manager, rank, MPI_COMM_WORLD);
  }
  MPI_Finalize();
  return 0;
}
