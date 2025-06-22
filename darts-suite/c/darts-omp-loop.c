/* Compute pi using OpenMP "pragma omp loop" */ 

/*  Written by Helen He, June 2024
    In this code, we are not using the pseudorandom number generator used in other codes,
    instead we use a complete random number generator rand() in C
    so we do not need to use an OMP critial region (which is not allowed to nest under omp loop)
    to reproduce the randon seeds.  
    so the final pi value is not bit-for-bit from other codes
    Also, it gives a different pi value every time it runs
*/

#include "lcgenerator.h"
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

static long num_trials = 1000000; 

int main(int argc, char **argv) {
  long i;
  long Ncirc = 0;
  double pi, x, y;
  double r = 1.0; /* radius of circle */
  double r2 = r*r;
    
#pragma omp parallel private(x,y) reduction(+:Ncirc)
{
#pragma omp loop
  for (i = 0; i < num_trials; i++) {
     x = (double) rand() / RAND_MAX;
     y = (double) rand() / RAND_MAX;
     if ((x*x + y*y) <= r2)
        Ncirc++;
  }
}

  pi = 4.0 * ((double)Ncirc)/((double)num_trials);
  printf("\n \t Computing pi using OpenMP: \n");
  printf("\t For %ld trials, pi = %f\n", num_trials, pi);
  printf("\n");

  return 0;
}
