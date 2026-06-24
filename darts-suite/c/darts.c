/* Compute pi in serial */
#include "lcgenerator.h"
#include <stdio.h>

int main() {
    long num_trials = 1000000;
    long Ncirc = 0;
    double pi, x, y;
    double r = 1.0;
    double r2 = r*r;
    long base_seed = 12345;
    long i;

    for (i = 0; i < num_trials; i++) {
        long thread_seed = base_seed + (i * 2L);

        x = lcgrandom_r(&thread_seed);
        y = lcgrandom_r(&thread_seed);

        if ((x*x + y*y) <= r2) {
            Ncirc++;
        }
    }

    pi = 4.0 * ((double)Ncirc) / ((double)num_trials);

    printf("\n \t Computing pi in serial: \n");
    printf("\t For %ld trials, pi = %f\n", num_trials, pi);
    printf("\n");

    return 0;
}
