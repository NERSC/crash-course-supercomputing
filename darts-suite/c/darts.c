/* Compute pi in serial */
#include "lcgenerator.h"
#include <stdio.h>
static long num_trials = 1000000;

int main(int argc, char **argv) {
  long i;
  long Ncirc = 0;
  double pi, x, y;
  double r = 1.0; // radius of circle
  double r2 = r*r;

  for (i = 0; i < num_trials; i++) {
    x = lcgrandom();
    y = lcgrandom();
    if ((x*x + y*y) <= r2)
      Ncirc++;
  }

  pi = 4.0 * ((double)Ncirc)/((double)num_trials);
  
  printf("\n \t Computing pi in serial: \n");
  printf("\t For %ld trials, pi = %f\n", num_trials, pi);
  printf("\n");

  return 0;
}
