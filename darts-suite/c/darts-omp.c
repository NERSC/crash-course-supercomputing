/* Compute pi using OpenMP */                
#include "lcgenerator.h"
#include <omp.h>
#include <stdio.h>

int main(void) {
    long num_trials = 1000000;
    long Ncirc = 0;
    double pi;
    double r = 1.0;
    double r2 = r*r;
    long base_seed = 12345;

#pragma omp parallel for reduction(+:Ncirc)
    for (long i = 0; i < num_trials; i++) {
        long thread_seed = base_seed + (i * 2L);

        double x = lcgrandom_r(&thread_seed);
        double y = lcgrandom_r(&thread_seed);

        if ((x*x + y*y) <= r2) {
            Ncirc++;
        }
    }

    pi = 4.0 * ((double)Ncirc) / ((double)num_trials);
    printf("\n \t Computing pi using OpenMP For: \n");
    printf("\t For %ld trials, pi = %f\n", num_trials, pi);
    printf("\n");
    return 0;
}
