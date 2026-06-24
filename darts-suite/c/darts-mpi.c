/* Compute pi using the six basic MPI functions */
#include "lcgenerator.h"
#include <mpi.h>
#include <stdio.h>

int main(int argc, char **argv) {

    long num_trials = 1000000;
    long local_Ncirc = 0;
    long total_Ncirc = 0;
    long received_Ncirc;
    double pi, x, y;
    double r = 1.0;
    double r2 = r*r;
    long base_seed = 12345;
    
    int rank, size, manager = 0, source;
    MPI_Status status;

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

    if (rank == manager) {
        total_Ncirc = local_Ncirc;

        for (source = 1; source < size; source++) {
            MPI_Recv(&received_Ncirc, 1, MPI_LONG, source, 0, MPI_COMM_WORLD, &status);
            total_Ncirc += received_Ncirc;
        }

        pi = 4.0 * ((double)total_Ncirc) / ((double)num_trials);
        printf("\n \t Computing pi using six basic MPI functions: \n");
        printf("\t For %ld trials, pi = %f\n", num_trials, pi);
        printf("\n");
    } 
    else {
        MPI_Send(&local_Ncirc, 1, MPI_LONG, manager, 0, MPI_COMM_WORLD);
    }

    MPI_Finalize();
    return 0;
}
