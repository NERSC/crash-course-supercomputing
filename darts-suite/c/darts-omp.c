/* Compute pi using OpenMP */
#include "lcgenerator.h"
#include <omp.h>
#include <stdio.h>

int main() {
    long num_trials = 1000000;
    long Ncirc = 0;
    double pi;
    double r = 1.0;
    double r2 = r*r;
    long base_seed = 12345;

#pragma omp parallel reduction(+:Ncirc)
    {
        long i;
        double x, y;
        int tid = omp_get_thread_num();
        int total_threads = omp_get_num_threads();
        long my_trials = num_trials / total_threads;

        for (i = 0; i < my_trials; i++) {
            long global_i = tid + (i * total_threads);
            long thread_seed = base_seed + (global_i * 2L);

            x = lcgrandom_r(&thread_seed);
            y = lcgrandom_r(&thread_seed);

            if ((x*x + y*y) <= r2) {
                Ncirc++;
            }
        }
    }

    pi = 4.0 * ((double)Ncirc) / ((double)num_trials);
    printf("\n \t Computing pi using OpenMP: \n");
    printf("\t For %ld trials, pi = %f\n", num_trials, pi);
    printf("\n");
    return 0;
}
