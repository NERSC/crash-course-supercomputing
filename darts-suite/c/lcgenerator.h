/* Thread-safe random number generator -- and not a very good one, either! */
static long MULTIPLIER = 1366;
static long ADDEND = 150889;
static long PMOD = 714025;

/* Thread-safe (reentrant) version of the linear congruential generator */
double lcgrandom_r(long *random_last) { 
    long random_next; 
    random_next = (MULTIPLIER * (*random_last) + ADDEND) % PMOD; 
    *random_last = random_next;

    return ((double)random_next / (double)PMOD);
}
