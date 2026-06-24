/* Compute pi using MPI Collectives */ 
#include "lcgenerator.h"
#include <mpi.h>
#include <stdio.h>

int main(int argc, char **argv) {
    long num_trials = 1000000;
    long local_Ncirc = 0;
    long total_Ncirc = 0;
    double pi, x, y;
    double r = 1.0;
    double r2 = r*r;
    long base_seed = 12345;
    int rank, size, manager = 0;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    long my_trials = num_trials / size;

    for (long i = 0; i < my_trials; i++) {
        long thread_seed = base_seed + (rank + (i * size)) * 2L;

        x = lcgrandom_r(&thread_seed);
        y = lcgrandom_r(&thread_seed);

        if ((x*x + y*y) <= r2) {
            local_Ncirc++;
        }
    }

    MPI_Reduce(&local_Ncirc, &total_Ncirc, 1, MPI_LONG, MPI_SUM, manager, MPI_COMM_WORLD);

    if (rank == manager) {
        pi = 4.0 * ((double)total_Ncirc) / ((double)num_trials);
        printf("\n \t Computing pi using MPI collectives: \n");
        printf("\t For %ld trials, pi = %f\n", num_trials, pi);
        printf("\n");
    }

    MPI_Finalize();
    return 0;
}
