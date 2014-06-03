// Random number generator -- and not a very good one, either!

static long MULTIPLIER = 1366;
static long ADDEND = 150889;
static long PMOD = 714025;
long random_last = 0;

// This is not a thread-safe random number generator

double lcgrandom() {
  long random_next;
  random_next = (MULTIPLIER * random_last + ADDEND)%PMOD;
  random_last = random_next;

  return ((double)random_next/(double)PMOD);
}
