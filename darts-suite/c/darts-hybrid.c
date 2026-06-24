/* Compute pi using hybrid MPI/OpenMP */
#include "lcgenerator.h"
#include <mpi.h>
#include <omp.h>
#include <stdio.h>

int main(int argc, char **argv) {

    long num_trials = 1000000;  /* Statically initialized on all processes */
    long total_Ncirc = 0;
    long local_rank_Ncirc = 0;
    double pi;
    double r = 1.0;
    double r2 = r*r;
    long base_seed = 12345;

    int rank, size, manager = 0;
    int total_threads = 1;
    int provided;

    MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &provided);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    #pragma omp parallel
    {
        #pragma omp single
        total_threads = omp_get_num_threads();
    }

    long trials_per_rank = num_trials / size;
    long trials_per_thread = trials_per_rank / total_threads;

    #pragma omp parallel reduction(+:local_rank_Ncirc)
    {
        int tid = omp_get_thread_num();
        double x, y;

        for (long i = 0; i < trials_per_thread; i++) {
            long global_i = (rank * total_threads) + tid + (i * (size * total_threads));
            long thread_seed = base_seed + (global_i * 2L);

            x = lcgrandom_r(&thread_seed);
            y = lcgrandom_r(&thread_seed);

            if ((x*x + y*y) <= r2) {
                local_rank_Ncirc++;
            }
        }
    }

    MPI_Reduce(&local_rank_Ncirc, &total_Ncirc, 1, MPI_LONG, MPI_SUM, manager, MPI_COMM_WORLD);

    if (rank == manager) {
        pi = 4.0 * ((double)total_Ncirc) / ((double)num_trials);
        printf("\n \t Computing pi using hybrid MPI/OpenMP: \n");
        printf("\t For %ld trials, pi = %f\n", num_trials, pi);
        printf("\n");
    }

    MPI_Finalize();
    return 0;
}
